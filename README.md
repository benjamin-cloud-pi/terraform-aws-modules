# Terraform AWS Modules

Repositorio interno para módulos Terraform AWS reutilizables, diseñados para ser consumidos desde un repositorio separado de infraestructura live con Terragrunt.

## Propósito

El objetivo de este repositorio es construir una librería curada de módulos Terraform para AWS que sean:

- Pequeños y enfocados.
- Seguros por defecto.
- Configurables sin dejar de ser opinionados.
- Consistentes en naming, tags, inputs y outputs.
- Aptos para múltiples cuentas, regiones y entornos.
- Alineados con AWS Well-Architected.
- Fáciles de consumir desde Terragrunt usando referencias versionadas.

Este repositorio contiene únicamente blueprints reutilizables. La infraestructura real por cuenta, región y entorno debe vivir en otro repositorio.

## Qué contiene este repositorio

En la fase documental inicial, el repositorio contiene estándares, checklist y roadmap:

```text
terraform-aws-modules/
├── README.md
├── AGENTS.md
├── ROADMAP.md
├── MODULE_STANDARD.md
├── WELL_ARCHITECTED_CHECKLIST.md
├── .gitignore
└── modules/
    └── .gitkeep
```

Los módulos concretos se crearán más adelante, uno por uno, cuando sean solicitados.

## Modelo de uso con Terragrunt

Este repositorio no debe contener configuración live de Terragrunt. Terragrunt debe vivir en un repositorio separado, por ejemplo:

```text
terraform-live/
├── mgmt/
├── nonprod/
└── prod/
```

Cuando exista un módulo versionado, el repositorio live podrá consumirlo con una referencia similar a:

```hcl
terraform {
  source = "git::ssh://git@github.com/org/terraform-aws-modules.git//modules/s3-bucket?ref=v1.0.0"
}
```

Los valores concretos de cuenta, región, entorno y organización deben definirse en el repositorio live, no en esta librería de módulos.

## Orden de implementación

La implementación debe avanzar de forma incremental. El orden inicial recomendado es:

1. `s3-bucket`
2. `kms-key`
3. `cloudwatch-log-group`
4. `iam-role`
5. `security-group`
6. `vpc`
7. `vpc-endpoints`
8. `route53-record`
9. `acm-certificate`
10. `rds`
11. `dynamodb`
12. `elasticache`
13. `backup-plan`
14. `lambda`
15. `ecs-cluster`
16. `ecs-service`
17. `alb`
18. `eks`
19. `cloudfront`
20. `waf`
21. `guardduty`
22. `securityhub`
23. `config`
24. `cloudtrail`

No se deben crear todos los módulos de una vez.

## Reglas de trabajo

- Inspeccionar la estructura existente antes de cambiar archivos.
- Proponer un plan breve antes de modificar.
- Modificar sólo el documento o módulo solicitado.
- No crear configuración live de Terragrunt en este repositorio.
- No hardcodear account IDs, regiones reales, credenciales, ARNs reales ni valores organizacionales.
- No incluir backends remotos reales.
- No incluir archivos de estado ni `tfvars` locales.
- Mantener defaults seguros en cada módulo futuro.
- Revisar cada módulo futuro contra `WELL_ARCHITECTED_CHECKLIST.md`.

## Documentos principales

- `ROADMAP.md`: fases incrementales de implementación.
- `MODULE_STANDARD.md`: estándar interno para estructura, naming, tags, versionado y definition of done.
- `WELL_ARCHITECTED_CHECKLIST.md`: checklist de revisión por los seis pilares de AWS Well-Architected.
- `AGENTS.md`: reglas de colaboración para asistentes de desarrollo.
