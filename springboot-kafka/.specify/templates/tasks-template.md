---
description: "Task list template for feature implementation"
---

# Tasks: [FEATURE NAME]

**Input**: Design documents from `/specs/[###-feature-name]/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The examples below include test tasks. Tests are OPTIONAL - only include them if explicitly requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Full-stack project**: `backend/` for Spring Boot backend, `frontend/` for React frontend styled with Tailwind CSS
- Backend source code: `backend/src/`
- Frontend source code: `frontend/src/`
- Tests for backend and frontend are located in their respective directories
- Adjust paths below based on plan.md structure

<!--
  ============================================================================
  IMPORTANT: The tasks below are SAMPLE TASKS for illustration purposes only.

  The /speckit.tasks command MUST replace these with actual tasks based on:
  - User stories from spec.md (with their priorities P1, P2, P3...)
  - Feature requirements from plan.md
  - Entities from data-model.md
  - Endpoints from contracts/

  Tasks MUST be organized by user story so each story can be:
  - Implemented independently
  - Tested independently
  - Delivered as an MVP increment

  DO NOT keep these sample tasks in the generated tasks.md file.
  ============================================================================
-->

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure for both backend and frontend

- [ ] T001 Create backend project structure per implementation plan in `backend/`
- [ ] T002 Initialize Spring Boot project with required dependencies in `backend/`
- [ ] T003 [P] Configure linting and formatting tools for backend
- [ ] T004 Create frontend project structure per implementation plan in `frontend/`
- [ ] T005 Initialize React project with Tailwind CSS setup in `frontend/`
- [ ] T006 [P] Configure linting and formatting tools for frontend (e.g., ESLint, Prettier)
- [ ] T007 Setup Tailwind CSS configuration and integration with React in `frontend/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

Examples of foundational tasks (adjust based on your project):

- [ ] T008 Setup database schema and migrations framework in backend
- [ ] T009 [P] Implement authentication/authorization framework in backend
- [ ] T010 [P] Setup API routing and middleware structure in backend
- [ ] T011 Create base models/entities that all stories depend on in backend
- [ ] T012 Configure error handling and logging infrastructure in backend
- [ ] T013 Setup environment configuration management for backend and frontend
- [ ] T014 [P] Configure structured logging, metrics, and tracing (OpenTelemetry) in backend
- [ ] T015 [P] Add contract/schema registry integration and baseline contract tests
- [ ] T016 Setup frontend-backend integration:
  - Configure Axios client or other HTTP client in frontend to connect to backend API
  - Setup environment variables in frontend for backend API URLs

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - [Title] (Priority: P1) 🎯 MVP

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 1 (OPTIONAL - only if tests requested) ⚠️

**NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T017 [P] [US1] Contract test for [endpoint] in backend/tests/contract/test\_[name].py
- [ ] T018 [P] [US1] Integration test for [user journey] in backend/tests/integration/test\_[name].py
- [ ] T019 [P] [US1] Frontend component test for [feature] in frontend/tests/components/test\_[name].jsx

### Implementation for User Story 1

- [ ] T020 [P] [US1] Create [Entity1] model in backend/src/models/[entity1].java
- [ ] T021 [P] [US1] Create [Entity2] model in backend/src/models/[entity2].java
- [ ] T022 [US1] Implement [Service] in backend/src/services/[service].java (depends on T020, T021)
- [ ] T023 [US1] Implement [endpoint/feature] in backend/src/controllers/[file].java
- [ ] T024 [US1] Add validation and error handling in backend
- [ ] T025 [US1] Add logging for user story 1 operations in backend
- [ ] T026 [US1] Implement frontend components/pages for user story 1 in frontend/src/components/ or frontend/src/pages/
- [ ] T027 [US1] Add frontend validation and error handling for user story 1
- [ ] T028 [US1] Add logging and monitoring hooks in frontend for user story 1

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - [Title] (Priority: P2)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 2 (OPTIONAL - only if tests requested) ⚠️

- [ ] T029 [P] [US2] Contract test for [endpoint] in backend/tests/contract/test\_[name].py
- [ ] T030 [P] [US2] Integration test for [user journey] in backend/tests/integration/test\_[name].py
- [ ] T031 [P] [US2] Frontend component test for [feature] in frontend/tests/components/test\_[name].jsx

### Implementation for User Story 2

- [ ] T032 [P] [US2] Create [Entity] model in backend/src/models/[entity].java
- [ ] T033 [US2] Implement [Service] in backend/src/services/[service].java
- [ ] T034 [US2] Implement [endpoint/feature] in backend/src/controllers/[file].java
- [ ] T035 [US2] Integrate with User Story 1 components (if needed) in backend
- [ ] T036 [US2] Implement frontend components/pages for user story 2 in frontend/src/components/ or frontend/src/pages/
- [ ] T037 [US2] Integrate frontend components with backend API for user story 2

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - [Title] (Priority: P3)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 3 (OPTIONAL - only if tests requested) ⚠️

- [ ] T038 [P] [US3] Contract test for [endpoint] in backend/tests/contract/test\_[name].py
- [ ] T039 [P] [US3] Integration test for [user journey] in backend/tests/integration/test\_[name].py
- [ ] T040 [P] [US3] Frontend component test for [feature] in frontend/tests/components/test\_[name].jsx

### Implementation for User Story 3

- [ ] T041 [P] [US3] Create [Entity] model in backend/src/models/[entity].java
- [ ] T042 [US3] Implement [Service] in backend/src/services/[service].java
- [ ] T043 [US3] Implement [endpoint/feature] in backend/src/controllers/[file].java
- [ ] T044 [US3] Implement frontend components/pages for user story 3 in frontend/src/components/ or frontend/src/pages/

**Checkpoint**: All user stories should now be independently functional

---

[Add more user story phases as needed, following the same pattern]

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] TXXX [P] Documentation updates in docs/
- [ ] TXXX Code cleanup and refactoring in backend and frontend
- [ ] TXXX Performance optimization across all stories
- [ ] TXXX [P] Additional unit tests (if requested) in backend/tests/unit/ and frontend/tests/unit/
- [ ] TXXX Security hardening in backend and frontend
- [ ] TXXX Run quickstart.md validation

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete
- **Note**: Frontend setup and backend setup can proceed in parallel after foundational infrastructure is complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May integrate with US1 but should be independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - May integrate with US1/US2 but should be independently testable

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- Models before services
- Services before endpoints
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All tests for a user story marked [P] can run in parallel
- Models within a story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together (if tests requested):
Task: "Contract test for [endpoint] in backend/tests/contract/test_[name].py"
Task: "Integration test for [user journey] in backend/tests/integration/test_[name].py"
Task: "Frontend component test for [feature] in frontend/tests/components/test_[name].jsx"

# Launch all models for User Story 1 together:
Task: "Create [Entity1] model in backend/src/models/[entity1].java"
Task: "Create [Entity2] model in backend/src/models/[entity2].java"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (backend and frontend)
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together (backend and frontend)
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
