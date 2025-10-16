---
feature: "Amend constitution for springboot-kafka"
generated: 2025-10-16
---

# Tasks: Amend constitution for springboot-kafka

**Input**: Design documents from `specs/001-amend-constitution/`
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, optional `data-model.md`, `contracts/`

## Phase 1: Setup (Shared Infrastructure)

Purpose: Prepare directories, CI placeholders, and example artifacts so the work is reproducible and testable.

- [X] T001 Create feature contracts directory `specs/001-amend-constitution/contracts/` (ensure .gitkeep present)
- [X] T002 [P] Add example Avro schema `specs/001-amend-constitution/contracts/example-message.avsc` with a minimal record definition
- [X] T003 [P] Create quickstart skeleton `specs/001-amend-constitution/quickstart.md` describing validation steps for the Constitution Check
- [X] T004 Create CI helper folder `.ci/schema-compatibility/` and add `check_compatibility.sh` at `.ci/schema-compatibility/check_compatibility.sh`
- [ ] T005 [P] Create workflow placeholders: `.github/workflows/schema-compatibility.yml` and `.github/workflows/integration-tests.yml`
- [X] T006 Initialize docs folder `docs/observability.md` with a header and TOC entry for OpenTelemetry + Prometheus guidance
---

## Phase 2: Foundational (Blocking Prerequisites)

Purpose: Implement must-have infra and gating so user-story work is safe to begin. These tasks MUST complete before user stories.

- [ ] T007 Add OpenTelemetry + Micrometer example config to `docs/observability.md` (include application.yml snippet and Java agent notes)
- [ ] T008 [P] Add Testcontainers CI profile configuration in `src/test/resources/testcontainers.properties` (or repo-level test profile) to standardize CI integration tests
- [ ] T009 [P] Add schema compatibility check script `.ci/schema-compatibility/check_compatibility.sh` (invokes HTTP compat API against configured registry)
- [ ] T010 Create `specs/001-amend-constitution/contracts/README.md` documenting where to add schemas and the compatibility policy
- [ ] T011 Add integration Testcontainers example `tests/integration/ITSchemaCompatibilityTest.java` (skeleton class using Testcontainers + Schema Registry)
- [ ] T012 Add contract test skeleton `tests/contract/ContractCompatibilityTest.java` demonstrating loading `example-message.avsc` and invoking the script
- [ ] T013 Add CI job file `.github/workflows/schema-compatibility.yml` that runs `.ci/schema-compatibility/check_compatibility.sh` on PRs

---

## Phase 3: User Story 1 - Finalize & Ratify Constitution (Priority: P1) 🎯 MVP

Goal: Complete, ratify, and publish the repository constitution so it becomes the authoritative source for repository governance.

Independent Test: The constitution file includes a RATIFICATION_DATE, ratifier list, and Sync Impact Report; `specs/001-amend-constitution/quickstart.md` contains a validation step that passes locally.

- [ ] T014 [US1] Update `.specify/memory/constitution.md` to set `RATIFICATION_DATE: 2025-10-15` (or final date) and add a `RatifiedBy` section with reviewers' usernames
- [ ] T015 [US1] Insert a short Sync Impact Report HTML comment block at the top of `.specify/memory/constitution.md` summarizing the change and affected templates
- [ ] T016 [US1] Add a one-paragraph summary and links to evidence in `specs/001-amend-constitution/quickstart.md` describing how to validate the Constitution Check locally
- [ ] T017 [US1] Create PR template for constitution ratification `.github/PULL_REQUEST_TEMPLATE/ratify-constitution.md` including a ratification checklist (signatures, approvals, docs updated)

---

## Phase 4: User Story 2 - Update Templates & Plan Gating (Priority: P2)

Goal: Ensure the repository templates enforce the Constitution Check and include the new foundational tasks so future plans automatically include governance gates.

Independent Test: New templates include the Constitution Check section and task placeholders; running the plan setup script copies a plan with the updated gate content.

- [ ] T018 [US2] Ensure `.specify/templates/plan-template.md` contains the explicit Constitution Check checklist and guidance (update evidence links to point to `.specify/memory/constitution.md`)
- [ ] T019 [US2] Ensure `.specify/templates/tasks-template.md` includes foundational tasks for observability and contract testing (T009b/T009c equivalents)
- [ ] T020 [US2] Add an example filled plan at `specs/001-amend-constitution/plan.md` that demonstrates how to pass the Constitution Check (include evidence links)
- [ ] T021 [US2] Add a test helper script `.specify/scripts/bash/validate-constitution.sh` that verifies templates include the Constitution Check and returns non-zero on failure

---

## Phase 5: User Story 3 - CI + Integration Tests (Priority: P3)

Goal: Implement CI jobs and example tests to enforce schema compatibility and integration checks in PRs.

Independent Test: PR triggers `schema-compatibility` workflow and `integration-tests` workflow; example tests run successfully in CI simulation.

- [ ] T022 [US3] Implement `.github/workflows/schema-compatibility.yml` to run `.ci/schema-compatibility/check_compatibility.sh` on PRs
- [ ] T023 [US3] Implement `.github/workflows/integration-tests.yml` to run Testcontainers-based integration tests (`tests/integration/ITSchemaCompatibilityTest.java`) in CI
- [ ] T024 [US3] Create `tests/integration/ITMessagingFlowTest.java` — example end-to-end test that produces & consumes a message using Testcontainers Kafka + Schema Registry
- [ ] T025 [US3] Add `docs/release.md` describing release gating for schema changes and required migration plan artifacts
- [ ] T026 [US3] Add a sample schema `specs/001-amend-constitution/contracts/example-message.avsc` (if not already added in Phase 1) and reference it in contract tests

---

## Phase N: Polish & Cross-Cutting Concerns

Purpose: Final documentation, cleanup, and release-readiness tasks.

- [ ] T027 [P] Update repository README or docs index with a short note about the Constitution and link to `specs/001-amend-constitution/` (file: `README.md`)
- [ ] T028 [P] Run `specify check` and verify all speckit templates produce no missing placeholders (update any placeholder remnants in `.specify/templates/`)
- [ ] T029 [P] Run the quickstart in `specs/001-amend-constitution/quickstart.md` and record the validation steps and results in `specs/001-amend-constitution/quickstart.md`

---

## Dependencies & Execution Order

- Setup (Phase 1) must complete first. Foundational (Phase 2) blocks all User Stories.
- After Foundational completes, User Stories (Phase 3/4/5) may proceed in priority order or in parallel if staffed.

### Suggested execution order (minimal):
1. Phase 1 (T001..T006)
2. Phase 2 (T007..T013)
3. Phase 3 (T014..T017) — MVP: ratify constitution
4. Phase 4 (T018..T021)
5. Phase 5 (T022..T026)
6. Phase N (T027..T029)

## Parallel execution examples

- Run T002, T003, T005, T006 in parallel (adding example schema, quickstart, and workflow placeholders)
- While T009 and T011 (schema script + CI job) are being implemented, authors can concurrently write contract test skeletons (T012)
- After Phase 2 completes, teams can implement User Stories 1..3 in parallel across different engineers

## Implementation strategy

- MVP: Complete Phase 1 + Phase 2 + Phase 3 (T001..T017) so the constitution is ratified and basic gating exists.
- Incremental: Add CI and integration tests (Phase 5) next, then polish docs and release gating.
- Test-first guidance: For contract & integration tasks, start by adding failing tests (T012, T011) before implementing the CI scripts.

## Generated artifacts

- Path: `specs/001-amend-constitution/tasks.md`
- Total tasks: 29
- Tasks per story/phase:
  - Phase 1 (Setup): 6
  - Phase 2 (Foundational): 7
  - User Story 1 (US1 P1): 4
  - User Story 2 (US2 P2): 4
  - User Story 3 (US3 P3): 5
  - Polish & Cross-cutting: 3

## Summary & MVP suggestion

- Suggested MVP: T001..T017 (Complete Setup, Foundational infra, and ratify constitution). This yields a ratified constitution and initial gating in templates.
- Parallel opportunities: schema/example artifact creation, workflow placeholders, and docs updates.
- Independent test criteria (per story):
  - US1: `specs/001-amend-constitution/quickstart.md` validation steps pass locally and show constitution file ratified.
  - US2: Running `.specify/scripts/bash/setup-plan.sh` produces a plan.md with Constitution Check present and evidence links.
  - US3: CI job `schema-compatibility` runs and validates example schema against the registry (or registry simulator).

---

Implementation notes: All tasks are intentionally specific with file paths so an LLM or developer can implement them directly. If you want, I can now create the files for the example schema, CI scripts, and workflow placeholders, commit them to `001-amend-constitution`, and push the changes.
# Tasks for: Amend constitution (001-amend-constitution)

## Phase 1: Foundation (complete before other changes)

- [ ] T001 Update `.specify/memory/constitution.md` with final content (PR)
- [ ] T002 Update `.specify/templates/plan-template.md` to include Constitution Check (done)
- [ ] T003 Update `.specify/templates/tasks-template.md` to add observability and contract foundational tasks (done)
- [ ] T004 Create or verify schema registry integration (T009c style task)
- [ ] T005 Configure OpenTelemetry and Prometheus exporters (T009b style task)

## Phase 2: Validation

- [ ] T101 Run CI to verify no gating failures (unit/contract/integration)
- [ ] T102 Update docs/quickstart to reference constitution requirements
- [ ] T103 Merge PR and confirm agent-context updates are preserved
