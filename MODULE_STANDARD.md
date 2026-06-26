# Module Standard

Estándar interno para crear módulos Terraform AWS reutilizables.

## Objetivo

Todos los módulos de este repositorio deben ser:

- Reutilizables.
- Seguros por defecto.
- Componibles desde Terragrunt.
- Consistentes en estructura, naming, tags, inputs y outputs.
- Alineados con AWS Well-Architected.
- Aptos para múltiples cuentas, regiones y entornos.

Este repositorio contiene únicamente módulos reutilizables. La configuración live por cuenta, región y entorno debe vivir en un repositorio separado.

## Estructura estándar

Cada módulo futuro debe seguir esta estructura:

```text
modules/<module-name>/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── locals.tf
├── data.tf
├── README.md
└── examples/
    └── basic/
        ├── main.tf
        └── outputs.tf
```

Notas:

- `locals.tf` debe usarse cuando existan valores derivados, naming o tags calculados.
- `data.tf` debe existir sólo cuando el módulo use data sources.
- `examples/basic` debe ser mínimo y no debe incluir valores reales de organización.
- El módulo no debe configurar backend.
- El módulo no debe configurar provider con región o cuenta hardcodeada.

## Naming

Los módulos deben usar nombres cortos, claros y enfocados:

- `s3-bucket`
- `kms-key`
- `cloudwatch-log-group`
- `iam-role`
- `security-group`
- `vpc`

Evitar módulos amplios o ambiguos:

- `full-platform`
- `complete-application`
- `all-infra`
- `network-security-compute-database`

Para nombres de recursos, usar una convención componible basada en inputs:

```text
<project>-<environment>-<name>
```

Ejemplo no organizacional:

```text
example-dev-artifacts
```

No incluir datos sensibles en nombres de recursos, tags, variables ni outputs.

## Inputs

Todas las variables deben:

- Tener `description`.
- Tener `type`.
- Evitar `any` salvo justificación.
- Usar defaults seguros cuando tenga sentido.
- Incluir validaciones para valores críticos.
- No contener valores reales de cuentas, regiones, ARNs o credenciales.

Variables comunes recomendadas:

```hcl
variable "project" {
  description = "Project identifier used for naming."
  type        = string
}

variable "environment" {
  description = "Environment name, such as dev, qa, stg or prod."
  type        = string
}

variable "name" {
  description = "Short resource name."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to taggable resources."
  type        = map(string)
  default     = {}
}
```

## Tags

Todos los módulos deben soportar tags y aplicarlos a todos los recursos taggeables.

Tags requeridos:

- `Owner`
- `Environment`
- `CostCenter`
- `ManagedBy`

Tags recomendados:

- `Application`
- `Component`
- `Repository`
- `BusinessUnit`
- `Criticality`
- `DataClassification`

Los tags no deben contener secretos, correos personales, account IDs, ARNs reales ni valores sensibles.

## Outputs

Todos los outputs deben:

- Tener `description`.
- Exponer identificadores útiles para composición.
- Evitar secretos.
- Usar `sensitive = true` cuando corresponda.

Los outputs deben facilitar consumo desde Terragrunt y composición entre módulos, sin obligar a depender de nombres internos innecesarios.

## Versiones

Cada módulo debe declarar versiones mínimas en `versions.tf`:

- `required_version` para Terraform.
- `required_providers` para AWS.

El repositorio debe publicar cambios con Semantic Versioning:

- `v1.0.0`: primera versión estable.
- `v1.1.0`: funcionalidad nueva compatible.
- `v1.1.1`: fix compatible.
- `v2.0.0`: cambio breaking.

Los consumidores Terragrunt deben referenciar módulos con `ref` versionado.

## Defaults seguros

Los módulos deben preferir defaults conservadores:

- Recursos privados por defecto.
- Cifrado habilitado donde aplique.
- Retención configurable.
- `force_destroy = false` donde aplique.
- IAM least privilege.
- Sin permisos administrativos por defecto.
- Sin exposición pública por defecto.
- Sin recursos costosos creados como efecto secundario.

Cuando un comportamiento riesgoso sea necesario, debe requerir configuración explícita y documentación.

## Compatibilidad con Terragrunt

Los módulos deben ser consumibles desde Terragrunt, pero este repositorio no debe contener configuración live de Terragrunt.

No incluir:

- `terragrunt.hcl` de entornos reales.
- Backends remotos reales.
- Account IDs reales.
- Regiones reales de una organización.
- Credenciales.
- `terraform.tfvars` con valores reales.
- Archivos de estado.

## Definition of Done

Un módulo está listo cuando:

- Sigue la estructura estándar.
- Tiene README propio.
- Tiene ejemplo básico.
- Tiene variables tipadas y documentadas.
- Tiene outputs documentados.
- Tiene validaciones razonables.
- Tiene defaults seguros.
- Aplica tags requeridos.
- No expone secretos.
- No configura backend ni provider hardcodeado.
- Es compatible con Terragrunt.
- Está revisado contra `WELL_ARCHITECTED_CHECKLIST.md`.
- No tiene riesgos altos abiertos.
- Pasa `terraform fmt` y `terraform validate`.

Herramientas adicionales recomendadas cuando apliquen:

- `tflint`
- `checkov`
- `terraform-docs`
