# Revision Completa del Modulo S3-Bucket

Este archivo se trata de una revision completa del modulo S3 donde se observa todo contenido .tf

##  **main.tf**

Contiene:

- `aws_s3_bucket` - Recurso principal con naming desde locals y tags
- `aws_S3_bucket_policy` - Politica condicional que deniega trafico inseguro (HTTP)
- `aws_s3_bucket_public_access_block` - Bloquea todo acceso publico (seguridad por defecto)
- `aws_s3_bucket_owership_controls` - Control de propiedad de objetos
- `aws_s3_bucket_server_side_encryption_configuration` - Encriptacion AES256

## **variables.tf**

Define 9 variables:

- `project`, `environment`, `name` - Componentes del naming (con validacion regex buscando patrones dentro de una cadena de texto) 
- `tags` - Tags Adicionales
- `force_destroy` - Permite borrar buckets no vacios
- `versioning_enabled` - Control De version
- `object_owership` - Control de propiedad (BucketOwnerEnforced por defecto)
- `enable_secure_transport` - Fuerza HTTPS
- `enable_lifecycle` - Habilita politicas de ciclo de vida
- `lifecycle_transition_to_ia_days`, `lifecycle_transition_to_glacier_days`, `lifecycle_expiration_days` - Configuracion de transiciones

## **outputs.tf**

Expone 8 outputs utiles:

- `bucket_id`, `bucket_name`, `bucket_arn` - identificadores
- `bucket_domain_name`, `bucket_regional_domain_name` - Acceso 
- `common_tags` - Tags Aplicados
- `bucket_policy` - Politica de seguridad
- `lifecycle_configuration` - Configuracion de ciclo de vida

## **locals.tf**

Define:

- `bucket_name` - Naming: {project}-{environment}-{name}
- `commong_tags` - Tags estandar: Project, Environment, Name, ManagedBy, Module

## **lifecycle.tf**

- `aws_s3_bucket_lifecycle_configuration` - Transicion automaticas (IA -> Glacier -> Expiracion)

## **versions.tf**

Define:

- Terraform >= 1.5.0
- AWS provider >= 5.0, < 6.0

## **data.tf**

Situacion: Actualmente solo contiene un comentario
> **vacio necesita actualizacion a futuro**
>
> 