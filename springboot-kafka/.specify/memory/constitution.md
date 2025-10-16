<!--
Sync Impact Report

- Version change: unset/template -> 1.0.0
-- Modified principles:
  - PRINCIPLE_1_NAME (template) -> Modular Services & Library-First
  - PRINCIPLE_2_NAME (template) -> Observable Messaging & Resilience
  - PRINCIPLE_3_NAME (template) -> Contract-First & Schema Evolution
  - PRINCIPLE_4_NAME (template) -> Test-First Integration
  - PRINCIPLE_5_NAME (template) -> Versioning, Compatibility & Simplicity
- Added sections: none (placeholders replaced)
- Removed sections: none
- Templates requiring updates:
	- .specify/templates/plan-template.md: ⚠ pending (review "Constitution Check" wording)
	- .specify/templates/spec-template.md: ✅ aligned (no mandatory changes required)
	- .specify/templates/tasks-template.md: ⚠ pending (ensure foundational tasks reflect observability/contract tests)
	- .specify/templates/commands/: ⚠ missing (no commands/ folder found; review any command docs referencing old agents)
- Follow-up TODOs:
	- TODO(RATIFICATION_DATE): original adoption date unknown — please set when known
	- Manual review of templates listed above to adjust gate text if needed
-->

# springboot-kafka Constitution

## Core Principles

### Modular Services & Library-First

Every feature or capability MUST be designed as a small, focused module or library
that can be built, versioned, tested, and released independently. Modules MUST
have clear public contracts and automated tests. Rationale: modular design
reduces coupling, simplifies testing, and enables independent evolution of the
Spring Boot services and Kafka integrations.

### Observable Messaging & Resilience

All messaging interactions (Kafka producers, consumers, stream processors)
MUST include structured logging, metrics, and tracing. Producers and consumers
MUST implement idempotency where applicable and apply exponential backoff and
retry policies for transient failures. Rationale: distributed message
processing must be observable and resilient to diagnose and recover from
failures quickly.

### Contract-First & Schema Evolution

Public contracts (Kafka topic schemas, REST/HTTP/CLI contracts, protobuf/Avro/JSON
schemas) MUST be defined and versioned explicitly. Any schema changes that are
breaking MUST follow a documented migration plan and be coordinated with
consumers. Rationale: contract-first prevents silent incompatibilities and
ensures safe schema evolution across producer/consumer boundaries.

### Test-First Integration

Tests MUST be written to cover unit, contract, and integration scenarios before
production code is accepted. Integration tests for Kafka interactions (end-to-
end processing, consumer offsets, schema compatibility) MUST be included in
CI and fail the pipeline on regressions. Rationale: messaging systems have
stateful behaviors that require integration verification to ensure correctness
under real conditions.

### Versioning, Compatibility & Simplicity

Library and service versions MUST follow semantic versioning for public APIs
and contracts. Backwards-compatible changes SHOULD be MINOR or PATCH bumps;
breaking changes MUST be MAJOR and accompanied by migration guidance. Favor
simplicity (YAGNI) in design: prefer clear, maintainable solutions over
premature generalization. Rationale: clear versioning and simplicity reduce
risk during deployments and upgrades.

## Additional Constraints

The project technology and operational constraints are:

- Language & Framework: Java (recommended 17+) with Spring Boot for service
  implementation. Build with Maven or Gradle and include reproducible builds.
- Messaging: Apache Kafka is the primary messaging backbone. Use a schema
  registry (Avro/Protobuf/JSON Schema) where feasible to enforce contract
  validation.
- Observability: Structured logs (JSON), OpenTelemetry-compatible tracing, and
  Prometheus-compatible metrics MUST be produced by services.
- Security: Secrets MUST be stored and accessed via approved secret stores; TLS
  for Kafka and HTTP endpoints MUST be used in production.
- Performance & Limits: Define p95 latency and throughput targets in feature
  plans; document any hard constraints in the plan artifacts.

## Development Workflow

- Pull Requests: All changes MUST be made via PRs and include a clear
  description, related spec/plan reference, and test coverage. PRs require at
  least one maintainer review and passing CI that includes unit, contract, and
  integration tests related to Kafka flows.
- CI Gates: Builds MUST run lint/format, unit tests, contract tests, and the
  relevant integration tests. Any Constitution MUST clauses violated by the
  change create a blocking failure in the pipeline.
- Releases: Releases MUST include changelogs that call out breaking changes,
  migration steps, and affected topics/schemas. Rolling upgrades are preferred
  for consumer groups to minimize disruption.
- Rollback & Migration: Any breaking schema or contract change MUST include a
  migration & rollback plan in the PR description and a checklist for safe
  deployment.

## Governance

The constitution is the normative source for development and release practices
for this repository. Amendments follow the procedure below:

- Proposal: Create a PR to `.specify/memory/constitution.md` that describes the
  proposed change, rationale, and migration plan for any downstream effects.
- Review: The PR MUST be reviewed by at least two maintainers or approvers.
- Approval: After approvals and passing CI, merge the PR. If the change is a
  breaking governance change (removing or redefining principles), a MAJOR
  version bump is required; if adding principles or materially expanding
  guidance, a MINOR bump is required; clarifications/typo fixes are PATCH
  bumps.
- Compliance Review: The implementation plan and feature specs MUST include a
  "Constitution Check" section populated from this file. Any violation of a
  MUST in this constitution during review is considered CRITICAL and must be
  addressed before merging.

**Version**: 1.0.0 | **Ratified**: TODO(RATIFICATION_DATE) | **Last Amended**: 2025-10-15
