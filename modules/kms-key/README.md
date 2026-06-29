# KMS Key Module

Módulo Terraform reutilizable para crear claves KMS en AWS con configuración segura y flexible.

## 📋 Descripción

Este módulo forma parte de la biblioteca interna de módulos Terraform AWS, diseñado para ser consumido desde un repositorio de infraestructura live, típicamente a través de Terragrunt.

### Características principales

✅ Creación de KMS key con configuración segura  
✅ Rotación automática de claves habilitada por defecto  
✅ Ventana de eliminación configurable (7-30 días)  
✅ Política base segura (permisos de cuenta raíz)  
✅ Alias automático basado en convención de nombres  
✅ Tags estandarizados y automatizados  
✅ Descripción configurable para auditoría  

## 🚀 Uso rápido

```hcl
module "kms_key" {
  source = "../../"

  project     = "example"
  environment = "dev"
  name        = "secrets"

  tags = {
    Owner      = "platform"
    CostCenter = "shared"
  }
}
```

El alias de la clave será: `alias/example-dev-secrets`

## 📝 Variables de entrada (Inputs)

### Requeridas

| Variable | Tipo | Descripción |
| --- | --- | --- |
| `project` | `string` | Identificador del proyecto. Usado en la convención de nombre de la clave. Ejemplo: `example`, `acme` |
| `environment` | `string` | Identificador del ambiente (dev, stg, prod, etc.). Usado en la convención de nombre de la clave. |
| `name` | `string` | Nombre corto del propósito de la clave. Ejemplo: `secrets`, `backup`, `database` |

### Opcionales

| Variable | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `tags` | `map(string)` | `{}` | Tags adicionales para aplicar a los recursos. |
| `description` | `string` | `Managed by Terraform` | Descripción de la clave KMS para auditoría. |
| `enable_key_rotation` | `bool` | `true` | Habilitar rotación automática de claves. |
| `deletion_window_in_days` | `number` | `30` | Ventana de eliminación de la clave en días (7-30). La destrucción accidental está bloqueada con `prevent_destroy`. |

## 📤 Outputs

| Output | Descripción |
| --- | --- |
| `key_id` | El identificador único global de la clave KMS |
| `key_arn` | El ARN de la clave KMS |
| `alias_name` | El alias de la clave KMS (ej: alias/example-dev-secrets) |
| `common_tags` | Tags comunes aplicadas a la clave |

## 🛡️ Seguridad (Well-Architected)

### ✅ Implementado

- **Rotación automática de claves** habilitada por defecto
- **Política base segura** con permisos de cuenta raíz
- **Protección contra destrucción accidental** mediante `prevent_destroy`
- **Ventana de eliminación** configurable para eliminaciones intencionales
- **Sin acceso público** - solo permisos de cuenta
- **Tags estandarizados** para auditoría y cumplimiento
- **Descripción configurable** para trazabilidad

### 🔐 Principios de seguridad aplicados

1. **Least Privilege**: Solo permisos necesarios asignados
2. **Defense in Depth**: Rotación automática + política restrictiva
3. **Secure by Default**: Rotación y ventana de eliminación activadas por defecto
4. **Auditabilidad**: Tags y descripción estandardizados para trazabilidad

## 📋 Ejemplos

### Ejemplo 1: Clave básica de desarrollo

```hcl
module "dev_secrets" {
  source = "../../"

  project     = "acme"
  environment = "dev"
  name        = "secrets"

  # Usa los defaults seguros (rotación activada, 30 días ventana)
}
```

### Ejemplo 2: Clave de producción con ventana de eliminación extendida

```hcl
module "prod_database" {
  source = "../../"

  project     = "acme"
  environment = "prod"
  name        = "database"

  description             = "KMS key for RDS encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = {
    Owner           = "devops"
    CostCenter      = "engineering"
    Compliance      = "sox"
    DataSensitivity = "high"
  }
}
```

### Ejemplo 3: Clave sin rotación (poco común, solo si es requerido)

```hcl
module "archive_key" {
  source = "../../"

  project     = "acme"
  environment = "prod"
  name        = "archive"

  enable_key_rotation     = false # Deshabilitar rotación
  deletion_window_in_days = 30

  tags = {
    Owner = "compliance"
  }
}
```

## 🏗️ Estructura del módulo

```
kms-key/
├── main.tf                          # KMS key, alias, política
├── variables.tf                     # Declaración de variables
├── outputs.tf                       # Outputs del módulo
├── locals.tf                        # Valores derivados y naming
├── data.tf                          # Data sources (caller identity)
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
  source = "git::https://your-repo.git//modules/kms-key?ref=v1.0.0"
}

inputs = {
  project     = local.project
  environment = local.environment
  name        = "my-key"

  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = local.common_tags
}
```

## ⚙️ Especificaciones técnicas

### Requisitos

- **Terraform**: >= 1.6.0
- **AWS Provider**: ~> 5.0

### Recursos AWS creados

| Recurso | Descripción |
| --- | --- |
| `aws_kms_key` | Clave KMS con rotación configurable |
| `aws_kms_alias` | Alias de la clave KMS |
| `aws_kms_key_policy` | Política de acceso a la clave (base segura) |

## 🔧 Consideraciones técnicas

### Validaciones de entrada

- `project`: 3-32 caracteres, minúsculas, números o hifens
- `environment`: 3-20 caracteres, minúsculas, números o hifens
- `name`: 3-32 caracteres, minúsculas, números o hifens
- `deletion_window_in_days`: Entre 7 y 30 días

### Naming de la clave

El alias de la clave se construye automáticamente como:

```
alias/{project}-{environment}-{name}
```

Ejemplo: `alias/acme-prod-database`

### Tags automáticos

Se aplican automáticamente a todos los recursos:

- `Project`: Del input `project`
- `Environment`: Del input `environment`
- `Name`: Nombre calculado del alias
- `ManagedBy`: "terraform"
- `Module`: "kms-key"
- Más los que proporciones en el input `tags`

### Política de clave base

La política base permite:

- Acceso completo al principal raíz de la cuenta AWS
- Otros usuarios/roles necesitan ser añadidos explícitamente mediante políticas adicionales

**Nota**: Para casos de uso específicos (S3, RDS, Secrets Manager, etc.), se recomienda crear políticas adicionales usando `aws_kms_key_policy` o `aws_kms_grant`.

## 🔑 Integración con otros servicios

La clave puede ser utilizada por:

- **S3**: Para cifrado de objetos
- **RDS**: Para cifrado de base de datos
- **EBS**: Para cifrado de volúmenes
- **Secrets Manager**: Para cifrado de secretos
- **CloudWatch Logs**: Para cifrado de logs
- **DynamoDB**: Para cifrado de tablas

## 📞 Soporte y documentación

Para más información sobre el módulo, consulta:

- [AWS KMS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)
- [Module Standard](../MODULE_STANDARD.md)
- [Well-Architected Checklist](../WELL_ARCHITECTED_CHECKLIST.md)
