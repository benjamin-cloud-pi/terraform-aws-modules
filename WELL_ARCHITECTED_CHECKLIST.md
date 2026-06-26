# Well-Architected Checklist

Checklist de revisión para módulos Terraform AWS reutilizables.

Debe usarse al diseñar, revisar y aprobar cada módulo antes de versionarlo o consumirlo desde Terragrunt.

## Severidades

### Alta

Debe corregirse antes de mergear o versionar.

- Recurso público por defecto.
- IAM excesivamente permisivo.
- Secreto hardcodeado.
- Cifrado deshabilitado en datos sensibles.
- Riesgo de pérdida de datos.
- Coste elevado inesperado.
- Cambio destructivo no documentado.

### Media

Debe resolverse o documentarse antes de considerar el módulo listo.

- Falta de tags requeridos.
- Falta de validaciones relevantes.
- README incompleto.
- Retención no configurable.
- Outputs insuficientes.
- Defaults poco claros.

### Baja

Mejora no bloqueante.

- Naming mejorable.
- Documentación ampliable.
- Outputs adicionales útiles.
- Refactor menor.

## 1. Excelencia operativa

### Estructura

- [ ] El módulo sigue `MODULE_STANDARD.md`.
- [ ] Existe `main.tf`.
- [ ] Existe `variables.tf`.
- [ ] Existe `outputs.tf`.
- [ ] Existe `versions.tf`.
- [ ] Existe `README.md`.
- [ ] Existe `examples/basic`.
- [ ] No configura backend.
- [ ] No configura provider con cuenta o región hardcodeada.

### Documentación

- [ ] El README explica el objetivo del módulo.
- [ ] El README lista los recursos creados.
- [ ] El README incluye uso básico.
- [ ] El README describe inputs principales.
- [ ] El README describe outputs principales.
- [ ] El README documenta riesgos y limitaciones.
- [ ] El README incluye consideraciones Well-Architected.
- [ ] El README menciona costes relevantes cuando aplica.

### Variables y outputs

- [ ] Todas las variables tienen `description`.
- [ ] Todas las variables tienen `type`.
- [ ] Se evitan variables `any` salvo justificación.
- [ ] Hay validaciones razonables.
- [ ] Los defaults son seguros.
- [ ] Todos los outputs tienen `description`.
- [ ] No se exponen secretos en outputs.
- [ ] Outputs sensibles usan `sensitive = true`.

### Tags y ownership

- [ ] El módulo soporta `tags`.
- [ ] Se validan tags requeridos.
- [ ] Incluye `Owner`.
- [ ] Incluye `Environment`.
- [ ] Incluye `CostCenter`.
- [ ] Incluye `ManagedBy`.
- [ ] Los tags no contienen datos sensibles.
- [ ] Los tags permiten trazabilidad operativa y FinOps.

## 2. Seguridad

### IAM

- [ ] Aplica least privilege.
- [ ] No usa `Action = "*"` salvo justificación documentada.
- [ ] No usa `Resource = "*"` salvo justificación documentada.
- [ ] Las policies están limitadas al recurso necesario.
- [ ] Las trust policies están restringidas.
- [ ] No crea usuarios IAM por defecto.
- [ ] No crea access keys por defecto.
- [ ] No asigna permisos administrativos por defecto.

### Cifrado y datos

- [ ] El cifrado en reposo está habilitado donde aplica.
- [ ] El cifrado en tránsito está soportado donde aplica.
- [ ] El módulo permite usar KMS donde corresponde.
- [ ] No hardcodea KMS Key IDs.
- [ ] No hardcodea secretos.
- [ ] No expone secretos en outputs.
- [ ] No guarda secretos en tags.
- [ ] No incluye datos sensibles en nombres de recursos.

### Exposición pública

- [ ] Los recursos no son públicos por defecto.
- [ ] S3 Public Access Block está habilitado cuando aplica.
- [ ] Security Groups no abren `0.0.0.0/0` salvo justificación.
- [ ] Security Groups no abren `::/0` salvo justificación.
- [ ] Puertos administrativos no están públicos por defecto.
- [ ] Load Balancers públicos requieren configuración explícita.
- [ ] Policies públicas requieren configuración explícita y documentación.

### Auditoría

- [ ] Logging disponible donde aplica.
- [ ] Métricas disponibles donde aplica.
- [ ] Alarmas configurables donde aplica.
- [ ] Retención de logs configurable.
- [ ] Logs sin secretos.
- [ ] Recursos taggeados para trazabilidad.

## 3. Fiabilidad

### Alta disponibilidad

- [ ] Soporta Multi-AZ cuando aplica.
- [ ] No fuerza una sola AZ sin justificación.
- [ ] Recursos críticos pueden desplegarse en múltiples subnets.
- [ ] Servicios stateful permiten alta disponibilidad cuando aplica.

### Backups y recuperación

- [ ] Backups configurables donde aplica.
- [ ] Versionado configurable donde aplica.
- [ ] Retención configurable.
- [ ] Deletion protection disponible para recursos críticos.
- [ ] `force_destroy` está deshabilitado por defecto cuando aplica.
- [ ] El comportamiento ante destrucción está documentado.

### Cambios seguros

- [ ] Evita reemplazos innecesarios.
- [ ] Cambios destructivos están documentados.
- [ ] Variables que fuerzan recreación están documentadas.
- [ ] Naming estable.
- [ ] No usa timestamps ni randoms innecesarios en nombres.
- [ ] Outputs facilitan composición segura.

### Dependencias

- [ ] Dependencias externas llegan por variables.
- [ ] No asume recursos externos no documentados.
- [ ] Data sources justificados.
- [ ] `depends_on` usado sólo cuando es necesario.
- [ ] Compatible con composición desde Terragrunt.

## 4. Eficiencia de rendimiento

### Capacidad

- [ ] Capacidad configurable donde aplica.
- [ ] Throughput configurable donde aplica.
- [ ] Storage configurable donde aplica.
- [ ] Tipos de instancia configurables donde aplica.
- [ ] Autoscaling soportado donde aplica.
- [ ] Defaults válidos para no producción sin limitar producción.

### Diseño

- [ ] Usa servicios gestionados cuando tiene sentido.
- [ ] No fuerza una única opción de performance sin justificación.
- [ ] Permite elegir storage class cuando aplica.
- [ ] Permite elegir engine/version cuando aplica.
- [ ] Documenta límites relevantes.

### Observabilidad

- [ ] Métricas disponibles donde aplica.
- [ ] Logs disponibles donde aplica.
- [ ] Alarmas configurables donde aplica.
- [ ] Outputs útiles para dashboards o alertas.

## 5. Optimización de costes

### Recursos costosos

- [ ] No crea recursos caros por defecto salvo que sea el propósito del módulo.
- [ ] NAT Gateways no se crean por defecto sin variable explícita.
- [ ] ALBs no se crean como efecto secundario inesperado.
- [ ] Bases de datos tienen sizing configurable.
- [ ] Instancias tienen tipo configurable.
- [ ] VPC endpoints son opcionales cuando pueden incrementar coste.
- [ ] Logs de alta retención son configurables.
- [ ] Recursos premium están documentados.

### Retención y lifecycle

- [ ] Retención de logs configurable.
- [ ] Retención de backups configurable.
- [ ] Lifecycle policies disponibles donde aplica.
- [ ] S3 soporta expiración o transición de storage class cuando aplica.
- [ ] Snapshots y versiones antiguas tienen controles de retención.

### FinOps

- [ ] Incluye `CostCenter`.
- [ ] Soporta tags de aplicación/componente.
- [ ] Todos los recursos taggeables están taggeados.
- [ ] Recursos sin soporte de tags están documentados.
- [ ] Costes relevantes están documentados en README.

## 6. Sostenibilidad

### Uso eficiente de recursos

- [ ] Evita overprovisioning por defecto.
- [ ] Permite reducir capacidad en no producción.
- [ ] Permite desactivar features opcionales.
- [ ] Evita recursos idle innecesarios.
- [ ] Soporta autoscaling u opciones on-demand cuando aplica.
- [ ] Evita duplicación innecesaria de recursos.

### Retención responsable

- [ ] Logs tienen retención configurable.
- [ ] Backups tienen retención configurable.
- [ ] Versiones antiguas tienen lifecycle configurable.
- [ ] Objetos antiguos pueden expirar o transicionar.
- [ ] No almacena datos indefinidamente por defecto salvo necesidad explícita.

### Defaults por entorno

- [ ] Defaults austeros para `dev`.
- [ ] Defaults razonables para `qa` y `stg`.
- [ ] Producción puede configurarse con mayor resiliencia.
- [ ] No obliga configuración productiva para todos los entornos.

## Checklist rápido para nuevo módulo

```markdown
### Estructura
- [ ] main.tf
- [ ] variables.tf
- [ ] outputs.tf
- [ ] versions.tf
- [ ] README.md
- [ ] examples/basic

### Terraform
- [ ] required_version definido
- [ ] required_providers definido
- [ ] sin backend hardcodeado
- [ ] sin provider hardcodeado
- [ ] variables tipadas y documentadas
- [ ] outputs documentados
- [ ] validaciones incluidas
- [ ] defaults seguros

### Seguridad
- [ ] recursos privados por defecto
- [ ] cifrado donde aplica
- [ ] KMS soportado donde aplica
- [ ] IAM least privilege
- [ ] sin secretos hardcodeados
- [ ] sin secretos en outputs
- [ ] sin exposición pública accidental

### Fiabilidad
- [ ] backups/versionado considerados
- [ ] Multi-AZ considerado
- [ ] deletion protection considerada
- [ ] cambios destructivos controlados
- [ ] outputs útiles

### Operación
- [ ] tags requeridos
- [ ] README completo
- [ ] ejemplo básico funcional
- [ ] naming consistente
- [ ] logs/métricas considerados

### Costes
- [ ] no crea recursos caros por defecto
- [ ] sizing configurable
- [ ] retención configurable
- [ ] lifecycle considerado
- [ ] tags FinOps incluidos

### Sostenibilidad
- [ ] evita recursos idle innecesarios
- [ ] permite desactivar features opcionales
- [ ] retención responsable
- [ ] defaults adecuados por entorno
```
