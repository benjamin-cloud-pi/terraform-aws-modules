# S3 Bucket Module

Módulo Terraform reutilizable para crear buckets S3 en AWS con defaults seguros y configuración flexible.

## 📋 Descripción

Este módulo forma parte de la biblioteca interna de módulos Terraform AWS, diseñado para ser consumido desde un repositorio de infraestructura live, típicamente a través de Terragrunt.

### Características principales

✅ Creación de S3 bucket con configuración segura  
✅ Bloqueo de acceso público por defecto  
✅ Cifrado de lado del servidor (AES-256)  
✅ Control de versiones configurable  
✅ Políticas de ciclo de vida para optimización de costos  
✅ Controles de propiedad de objetos  
✅ Tags estandarizados y automatizados  
✅ Soporte para transporte seguro (HTTPS)

## 🚀 Uso rápido

```hcl
module "s3_bucket" {
  source = "../../"

  project     = "example"
  environment = "dev"
  name        = "artifacts"

  tags = {
    Owner      = "platform"
    CostCenter = "shared"
  }
}
```

El nombre del bucket será: `example-dev-artifacts`

## 📝 Variables de entrada (Inputs)

### Requeridas

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `project` | `string` | Identificador del proyecto. Usado en la convención de nombre del bucket. Ejemplo: `example`, `acme` |
| `environment` | `string` | Identificador del ambiente (dev, stg, prod, etc.). Usado en la convención de nombre del bucket. |
| `name` | `string` | Nombre corto del propósito del bucket. Ejemplo: `artifacts`, `logs`, `backups` |

### Opcionales

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| `tags` | `map(string)` | `{}` | Tags adicionales para aplicar a los recursos. |
| `force_destroy` | `bool` | `false` | Permitir a Terraform destruir el bucket aunque contenga objetos. |
| `versioning_enabled` | `bool` | `true` | Habilitar versionado de objetos en el bucket. |
| `object_ownership` | `string` | `BucketOwnerEnforced` | Control de propiedad de objetos. Valores: `BucketOwnerEnforced`, `BucketOwnerPreferred`, `ObjectWriter` |
| `enable_secure_transport` | `bool` | `true` | Forzar transporte seguro (HTTPS) para acceso al bucket. |
| `enable_lifecycle` | `bool` | `true` | Habilitar política de ciclo de vida para optimización de costos. |
| `lifecycle_transition_to_ia_days` | `number` | `30` | Días antes de transicionar a almacenamiento Infrequent Access. |
| `lifecycle_transition_to_glacier_days` | `number` | `90` | Días antes de transicionar a almacenamiento Glacier. |
| `lifecycle_expiration_days` | `number` | `365` | Días antes de expirar objetos. (0 = deshabilitar) |
| `abor_incomplete_multipart_upload_days` | `number` | `7` | Días para cancelar cargas multiparte incompletas. |
| `kms_key_id` | `string` | `null` | ARN o ID de clave KMS para cifrado. Si es null, usa la clave AWS administrada. |

## 📤 Outputs

| Output | Descripción |
|--------|-------------|
| `bucket_id` | ID del bucket S3 |
| `bucket_name` | Nombre del bucket S3 |
| `bucket_arn` | ARN del bucket S3 |
| `bucket_domain_name` | Nombre de dominio del bucket |
| `bucket_regional_domain_name` | Nombre de dominio regional del bucket |
| `common_tags` | Tags comunes aplicadas al bucket |
| `bucket_policy` | Política del bucket (si está habilitada) |
| `lifecycle_configuration` | Configuración de ciclo de vida (si está habilitada) |

## 🛡️ Seguridad (Well-Architected)

### ✅ Implementado

- **Acceso público bloqueado** por defecto en todos los buckets
- **Cifrado de lado del servidor** con AES-256 habilitado
- **Transporte seguro** (HTTPS) forzado mediante política de bucket
- **Versioning** de objetos habilitado por defecto
- **Control de propiedad** de objetos para evitar problemas de propiedad
- **Tags estandardizados** para auditoría y cumplimiento
- **No expone secretos** en variables, tags u outputs

### 🔐 Principios de seguridad aplicados

1. **Least Privilege**: Solo lo necesario está habilitado
2. **Defense in Depth**: Múltiples capas de control
3. **Secure by Default**: La configuración segura es el default
4. **Auditabilidad**: Tags y naming estandarizado para trazabilidad

## 💰 Optimización de costos

El módulo incluye políticas automáticas de ciclo de vida que:

- Transicionan objetos no accedidos frecuentemente a **Infrequent Access** (IA) después de 30 días
- Transicionan a **Glacier** después de 90 días para archivo a largo plazo
- **Expiran objetos** después de 365 días

Esto reduce significativamente los costos de almacenamiento manteniendo los datos disponibles según sea necesario.

## 🔄 Ciclo de vida del bucket

```
Creación → STANDARD (0-30 días) → STANDARD_IA (30-90 días) → GLACIER (90-365 días) → Expiración (365+ días)
```

## 📋 Ejemplos

### Ejemplo 1: Bucket básico de desarrollo

```hcl
module "dev_artifacts" {
  source = "../../"

  project     = "acme"
  environment = "dev"
  name        = "artifacts"

  # Usa los defaults seguros
}
```

### Ejemplo 2: Bucket de producción con tags personalizados

```hcl
module "prod_logs" {
  source = "../../"

  project     = "acme"
  environment = "prod"
  name        = "application-logs"

  versioning_enabled = true
  enable_lifecycle   = true

  # Ciclo de vida personalizado
  lifecycle_transition_to_ia_days      = 7
  lifecycle_transition_to_glacier_days = 30
  lifecycle_expiration_days            = 180

  tags = {
    Owner          = "devops"
    CostCenter     = "engineering"
    Compliance     = "hipaa"
    DataClassification = "sensitive"
  }
}
```

### Ejemplo 3: Bucket sin ciclo de vida

```hcl
module "archive_storage" {
  source = "../../"

  project     = "acme"
  environment = "prod"
  name        = "archive"

  enable_lifecycle = false  # Deshabilitar ciclo de vida

  tags = {
    Owner = "compliance"
  }
}
```

## 🏗️ Estructura del módulo

```
s3-bucket/
├── main.tf                          # Recursos principales del bucket
├── lifecycle.tf                     # Configuración de ciclo de vida
├── variables.tf                     # Declaración de variables
├── outputs.tf                       # Outputs del módulo
├── locals.tf                        # Valores derivados y naming
├── data.tf                          # Data sources (si aplica)
├── versions.tf                      # Requerimientos de versión
├── README.md                        # Esta documentación
└── examples/
    └── basic/
        ├── main.tf                  # Ejemplo de uso
        └── outputs.tf               # Outputs del ejemplo
```

## 🚀 Próximos pasos

Para usar este módulo desde Terragrunt:

```hcl
# terragrunt.hcl
terraform {
  source = "git::https://your-repo.git//modules/s3-bucket?ref=v1.0.0"
}

inputs = {
  project     = local.project
  environment = local.environment
  name        = "my-bucket"

  tags = local.common_tags
}
```

## ⚙️ Especificaciones técnicas

### Requisitos

- **Terraform**: >= 1.5.0
- **AWS Provider**: >= 5.0, < 6.0

### Recursos AWS creados

| Recurso | Descripción |
| --- | --- |
| `aws_s3_bucket` | Bucket S3 principal |
| `aws_s3_bucket_public_access_block` | Bloqueo de acceso público |
| `aws_s3_bucket_ownership_controls` | Control de propiedad de objetos |
| `aws_s3_bucket_server_side_encryption_configuration` | Cifrado de lado del servidor (AES-256) |
| `aws_s3_bucket_versioning` | Versionado de objetos |
| `aws_s3_bucket_policy` | Política de transporte seguro (si está habilitada) |
| `aws_s3_bucket_lifecycle_configuration` | Ciclo de vida (si está habilitada) |

## 🔧 Consideraciones técnicas

### Validaciones de entrada

- `project`: 3-32 caracteres, minúsculas, números o hifens
- `environment`: 3-20 caracteres, minúsculas, números o hifens
- `name`: 3-32 caracteres, minúsculas, números o hifens
- `object_ownership`: Valores permitidos: `BucketOwnerEnforced`, `BucketOwnerPreferred`, `ObjectWriter`

### Naming del bucket

El nombre del bucket se construye automáticamente como:
```
{project}-{environment}-{name}
```

Ejemplo: `acme-prod-logs` (máximo 63 caracteres, AWS S3 limit)

### Tags automáticos

Se aplican automáticamente a todos los recursos:
- `Project`: Del input `project`
- `Environment`: Del input `environment`
- `Name`: Nombre calculado del bucket
- `ManagedBy`: "terraform"
- `Module`: "s3-bucket"
- Más los que proporciones en el input `tags`

## 📞 Soporte y documentación

Para más información sobre el módulo, consulta:
- [AWS S3 Bucket Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Module Standard](../MODULE_STANDARD.md)
- [Well-Architected Checklist](../WELL_ARCHITECTED_CHECKLIST.md)