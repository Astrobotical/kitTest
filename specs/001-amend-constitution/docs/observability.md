# Observability: OpenTelemetry + Prometheus

This document contains example configuration for enabling OpenTelemetry and
Micrometer Prometheus metrics in Spring Boot applications.

See `plan.md` and `research.md` for recommended snippets and agent usage.

## Example Spring Boot configuration (application.yml)

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

# Micrometer configuration example (use micrometer-registry-prometheus)
```

## OpenTelemetry Java agent notes

- The OpenTelemetry Java agent can be attached via the `-javaagent` JVM option.
- Example environment variables for CI or Docker runtime:

	- OTEL_EXPORTER_OTLP_ENDPOINT: http://otel-collector:4317
	- JAVA_TOOL_OPTIONS: -javaagent:/opentelemetry-javaagent.jar

- In CI, include the agent binary in the test runner image or download it during the workflow.

## Quick tips

- Expose `/actuator/prometheus` (Spring Boot Actuator) to enable Prometheus scraping.
- Use the OpenTelemetry Collector (OTel-Collector) to centralize and route telemetry to backends.

