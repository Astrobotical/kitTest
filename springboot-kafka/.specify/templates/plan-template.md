# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Java 17+ (repository default) — confirm if a different minor/patch target is required  
**Primary Dependencies**: Spring Boot (recommended starter), Apache Kafka client, Avro (or chosen schema library), OpenTelemetry Java agent  
**Storage**: N/A for ephemeral Kafka-only services; list persistent stores if this feature requires them (e.g., PostgreSQL)  
**Testing**: JUnit 5 (unit), Testcontainers (Kafka + Schema Registry for integration), contract tests (Avro/Schema validation)  
**Target Platform**: Linux server (containers) — CI and local dev should support Docker-based execution  
**Project Type**: Modular JVM services + library artifacts (service modules & shared-contracts package)  
**Performance Goals**: Define per-feature; common baseline: handle expected Kafka throughput with p95 processing latency <200ms unless otherwise noted  
**Constraints**: Cross-service schema compatibility, backward/forward compatibility requirements for topics, and limited reliance on broker-side features beyond standard Kafka APIs  
**Scale/Scope**: Service should be independently versioned; assume up to medium message volumes (100k messages/day) unless research indicates higher needs

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

This section MUST be completed using the repository constitution
(`.specify/memory/constitution.md`). At minimum, the plan MUST explicitly
confirm the following gates derived from the constitution:

- Modular Services: the proposed structure documents the module/library
  boundaries and independent release plan.
- Observability & Resilience: the plan lists logging/metrics/tracing
  requirements and the strategy for retries/idempotency for Kafka flows.
- Contract-First: all public schemas (topic schemas, API contracts) are
  identified and versioning/migration strategy is described.
- Test Coverage: unit, contract, and integration tests required for the
  feature are listed and included in CI gating criteria.
- Versioning & Migration: any change that may be breaking includes a
  migration and rollback plan and indicates the expected semantic versioning
  impact.

Fill out the short checklist below and attach links to the relevant files or
artifacts.

Constitution Gates (repository defaults pre-filled for springboot-kafka):

- Modular boundaries confirmed: [YES/NO] — evidence: [link to design or package listing]
  - Guidance: If YES, include module names (e.g., service-a, service-b, contracts) and the independent release/versioning strategy; if NO, document why a multi-module layout is infeasible.
- Observability plan provided: [YES/NO] — evidence: [link to quickstart or observability.md]
  - Guidance: List required metrics (processing_count, processing_errors, lag_ms), tracing (OpenTelemetry spans for processing pipeline), and log structure (structured JSON logs with correlation ids).
- Contracts/schemas listed: [YES/NO] — evidence: [link to `specs/<feature>/contracts/` or schema repo]
  - Guidance: Provide topic names, Avro/JSONSchema definitions, compatibility policy (BACKWARD/BRIDGE/FORWARD), and location (contracts/ or centralized registry).
- Test coverage plan (unit/contract/integration): [YES/NO] — evidence: [link to tests/ or CI job]
  - Guidance: Unit tests for business logic, contract tests validating schema compatibility, integration tests using Testcontainers (Kafka + Schema Registry), and CI gating to fail on contract or integration regressions.
- Migration/rollback plan present if needed: [YES/NO] — evidence: [link to migration.md or runbook]
  - Guidance: For any breaking change document a migration path (dual-write, versioned topics, consumer migration steps) and rollback steps; attach expected semantic version bump and downtime windows if applicable.

Quick acceptance criteria (check these before Phase 1 design):

- All public topic schemas are checked into `specs/<feature>/contracts/` or a referenced schema repo.
- CI includes a schema-compatibility job that validates new schemas against the target registry or compatibility baseline.
- Integration tests run with Testcontainers and are green locally and in CI.
- Observability (metrics & tracing) has at least one example instrumentation added in the quickstart.

## Project Structure

### Documentation (this feature)

```
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above]

## Complexity Tracking

_Fill ONLY if Constitution Check has violations that must be justified_

| Violation                  | Why Needed         | Simpler Alternative Rejected Because |
| -------------------------- | ------------------ | ------------------------------------ |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  |
