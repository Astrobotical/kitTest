# Quickstart: Validate Constitution Check

This quickstart shows how to validate that the Constitution has been ratified
and that the Constitution Check in templates passes locally.

Steps:

1. Ensure `.specify/memory/constitution.md` contains a `RATIFICATION_DATE` and `RatifiedBy`.
2. Run the local template validation:

   - `./.specify/scripts/bash/validate-constitution.sh specs/001-amend-constitution`

3. Confirm the quickstart validation steps documented in this file pass.

Summary:

This feature ratifies the repository Constitution (RATIFICATION_DATE: 2025-10-15) and adds gating that enforces schema/contract checks and observability guidance. Evidence: `.specify/memory/constitution.md` (ratification metadata), `specs/001-amend-constitution/contracts/example-message.avsc`, and `.ci/schema-compatibility/check_compatibility.sh`.
