# Terraform AWS Modules Roadmap

Este roadmap define el avance incremental de la librería interna de módulos Terraform AWS.

El repositorio debe evolucionar módulo por módulo. No se deben generar todos los módulos en una sola tarea.

## Phase 0 - Base documental

Crear únicamente la fundación documental y los estándares del repositorio:

- `README.md`
- `AGENTS.md`
- `ROADMAP.md`
- `MODULE_STANDARD.md`
- `WELL_ARCHITECTED_CHECKLIST.md`
- `.gitignore`
- `modules/.gitkeep`

En esta fase no se implementa ningún módulo AWS, no se agregan pipelines, no se agrega Terragrunt y no se agregan tests.

## Phase 1 - Módulos fundacionales core

Implementar estos módulos primero, uno por uno:

1. `s3-bucket`
2. `kms-key`
3. `cloudwatch-log-group`
4. `iam-role`
5. `security-group`

Cada módulo debe incluir estructura estándar, defaults seguros, README propio, ejemplo básico y consideraciones Well-Architected.

## Phase 2 - Fundaciones de red

Implementar de forma incremental:

1. `vpc`
2. `vpc-endpoints`
3. `route53-record`
4. `acm-certificate`

## Phase 3 - Servicios de datos

Implementar de forma incremental:

1. `rds`
2. `dynamodb`
3. `elasticache`
4. `backup-plan`

## Phase 4 - Compute y plataforma de aplicaciones

Implementar de forma incremental:

1. `lambda`
2. `ecs-cluster`
3. `ecs-service`
4. `alb`
5. `eks`

## Phase 5 - Edge y seguridad

Implementar de forma incremental:

1. `cloudfront`
2. `waf`
3. `guardduty`
4. `securityhub`
5. `config`
6. `cloudtrail`

## Criterio de avance

Un módulo puede considerarse listo para versionar cuando:

- Sigue `MODULE_STANDARD.md`.
- Tiene variables tipadas y documentadas.
- Tiene outputs documentados.
- Tiene validaciones donde aportan valor.
- Usa defaults seguros.
- Soporta tags requeridos.
- No expone secretos.
- Incluye al menos un ejemplo básico.
- Documenta consideraciones Well-Architected.
- Pasa formato y validación.
- Puede consumirse desde Terragrunt con una referencia versionada.

## Prioridad actual

La primera implementación futura recomendada es:

```text
modules/s3-bucket
```

No debe crearse hasta que se solicite explícitamente.
