# contracts/ README

This folder stores contract artifacts (Avro/Protobuf/JSON Schema) related to
the feature. For the constitution update, use this folder to store any sample
schema or migration plan if a contract change is proposed.

Recommended workflow:

- Add schema files under this directory, named with a clear version (e.g.,
  `topic-name-v1.avsc`).
- Include a migration plan for any breaking changes (describe the rolling
  upgrade steps and consumer compatibility strategy).
- Use the team-approved schema registry to publish/validate schemas as part of
  CI checks.
