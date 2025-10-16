# research.md — Phase 0: Clarifications & Findings

Feature: Amend constitution for springboot-kafka
Date: 2025-10-15

## Decisions & Unknowns (NEEDS CLARIFICATION)

1. Schema Registry: which implementation will the repo recommend/use in
   production? (Confluent Schema Registry vs. open-source alternatives).

   - Task: Research pros/cons, cost, and compatibility.

2. Contract testing framework: preferred tooling (e.g., Pact, custom Avro
   compatibility checks, protobuf tools).

   - Task: Research best practice for contract testing with Kafka and chosen
     schema format.

3. Integration test approach: embedded Kafka vs Testcontainers (CI runtime
   implications).

   - Task: Recommend an approach that balances speed and CI reliability.

4. Observability stack: recommended OpenTelemetry exporter setup and
   Prometheus metrics configuration for Spring Boot + Kafka.

   - Task: Provide configuration snippets and minimal dependency list.

5. Release process expectations: are releases automated (CI-driven) or manual
   for this project? (affects changelog and migration gating)
   - Task: Recommend a release flow consistent with constitution rules.

## Research Tasks

- Research 1: Compare Schema Registry options (Confluent vs alternatives)
- Research 2: Evaluate contract testing tools for Kafka (Pact, Avro/Proto
  compatibility checks)
- Research 3: Testcontainers vs embedded Kafka tradeoffs and example CI
  configurations
- Research 4: OpenTelemetry + Prometheus patterns for Spring Boot + Kafka
- Research 5: Recommended release workflow (automated via CI vs manual)

## Consolidated Findings (decisions, rationale, alternatives)

### 1) Schema Registry

- Decision: Recommend Avro schemas stored in a Schema Registry. Use
  Confluent Schema Registry if the organization can accept the licensing/costs;
  otherwise use an open-source alternative such as Apicurio or Redpanda's
  schema registry implementation.
- Rationale: Avro + Schema Registry is the most widely-supported combination in
  the Java + Kafka ecosystem, with mature compatibility tooling and testable
  compatibility rules. Confluent offers robust compatibility checks and
  enterprise features; Apicurio/Redpanda are viable zero-cost alternatives.
- Alternatives considered:
  - Protobuf: good for strong typing and codegen; slightly more complex
    compatibility semantics for some teams.
  - JSON Schema: more flexible, human-readable; less compact storage and fewer
    binary toolchains for the JVM ecosystem.

### 2) Contract testing tooling

- Decision: Enforce schema compatibility in CI (schema-registry compatibility
  checks) as the primary defense. Augment with consumer-driven contract tests
  for critical message flows using consumer-driven contract tooling (Pact
  messaging or consumer-side contract tests implemented in JUnit + Testcontainers).
- Rationale: Schema compatibility checks are fast and prevent many classes of
  regressions. Consumer-driven contracts add behavioral verification where
  schemas alone are insufficient (e.g., semantic constraints, business rules).
- Alternatives considered:
  - Pact only: Pact has messaging support but is less commonly used in pure
    Kafka-first Java shops; it's a valuable augmentation but not a replacement
    for schema compatibility checks.

### 3) Integration test approach (embedded Kafka vs Testcontainers)

- Decision: Use embedded Kafka (spring-kafka-test) for fast local unit /
  developer tests, and use Testcontainers (Kafka container + Schema Registry
  container) in CI for integration tests and contract verification.
- Rationale: Embedded Kafka is fast and useful for unit-level verification; but
  Testcontainers provides a closer-to-production environment (container
  networking, actual broker behavior) and is recommended for CI and gating.
- Alternatives considered:
  - Only embedded Kafka: faster but can miss integration issues that appear in
    containerized brokers (connectivity, network behavior, container image
    differences).

### 4) Observability stack

- Decision: Standardize on OpenTelemetry for tracing + Micrometer Prometheus
  integration for metrics. Use the OpenTelemetry Collector to receive OTLP
  and route to tracing and monitoring backends (Tempo/Jaeger for traces,
  Prometheus for metrics via a scrape or exporter).
- Rationale: OTel is the current standard and integrates well with Micrometer
  via the micrometer-registry-prometheus bridging. This provides vendor-
  neutral telemetry and good community support.
- Minimal Spring Boot config snippet (application.yml):

```yaml
management:
   endpoints:
      web:
         exposure:
            include: prometheus,health,info
management:
   metrics:
      export:
         prometheus:
            enabled: true

spring:
   metrics:
      enabled: true

# Environment variables for OpenTelemetry Java agent
OTEL_EXPORTER_OTLP_ENDPOINT: http://otel-collector:4317
JAVA_TOOL_OPTIONS: -javaagent:/opentelemetry-javaagent.jar
```

### 5) Release process

- Decision: CI-driven releases (GitHub Actions) using semantic versioning.
  Automate changelog generation from conventional commits or maintain a
  maintained changelog in PRs. Schema/contract changes MUST run compatibility
  checks and a staged validation before publishing a breaking change.
- Rationale: Automating releases reduces human error and encourages frequent
  safe releases; staging checks prevent accidental breaking changes.
- Recommended gating rule: Any schema change that is not backward-compatible
  requires a documented migration plan and a MAJOR version bump for the
  affected artifact.

## Actionable next steps (short-term)

1. Add CI job for schema compatibility checks (example for Confluent Schema
   Registry using `compatibility` API). If using Confluent OSS, run a curl to
   registry endpoint to validate compatibility as part of PR pipeline.
2. Add Testcontainers-based integration test profile in CI for at-least one
   end-to-end test including schema registry.
3. Add OpenTelemetry Java agent to base Docker images or CI test runs and set
   environment variable `OTEL_EXPORTER_OTLP_ENDPOINT` to your collector.
4. Document release gating: schema changes require migration plan + staged
   deployment; include a checklist template in `specs/001-amend-constitution/`
   or global `.specify` docs.

## Example CI job (schema compatibility check)

This is a simplified example using a script to check Avro compatibility against
an existing subject in Confluent Schema Registry. Adjust for your registry
and authentication.

```bash
# upload new schema (test subject) and check compatibility
curl -s -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
   --data '{"schema": "$(jq -Rs . < new-schema.avsc)"}' \
   http://schema-registry:8081/subjects/my-topic-value/versions?validate=true

# Or check compatibility endpoint explicitly
curl -s -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
   --data '{"schema": "$(jq -Rs . < new-schema.avsc)"}' \
   http://schema-registry:8081/compatibility/subjects/my-topic-value/versions/latest
```

## Who should act next

- Engineering lead: confirm acceptance of recommended stack (Avro + Schema
  Registry, OTel + Prometheus, Testcontainers for CI).
- CI maintainer: implement schema-compatibility job and Testcontainers CI job.
- Developer: add one contract test and a Testcontainers-based integration test
  to validate the approach.
