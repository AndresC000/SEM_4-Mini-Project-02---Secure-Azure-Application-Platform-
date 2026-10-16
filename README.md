# Mini Proyecto 02 - Plataforma de Aplicación Segura en Azure

## Descripción General

Este proyecto implementa una plataforma web segura en Azure utilizando Infraestructura como Código (IaC) mediante Azure Bicep.

La solución incluye:

- Azure Virtual Network (VNet)
- Azure Application Gateway
- Máquinas Virtuales Ubuntu
- Azure Storage Account
- Azure Key Vault
- Azure Log Analytics Workspace
- Network Security Groups (NSG)

La arquitectura sigue buenas prácticas de Azure mediante la segmentación de la red, la centralización del tráfico de entrada y el despliegue modular de la infraestructura.

---

# Arquitectura de la Solución

![Arquitectura]("./Architecture/DesignerMini-Proyect-02-SAAP.png")

---

# Componentes de la Arquitectura

## Grupo de Recursos

rg-secure-app-prod

**NOTA**

Antes de desplegar la solución, crear el Resource Group:

az group create \
--name rg-secure-app-prod \
--location eastus

Contenedor lógico que almacena todos los recursos del proyecto.

---

## Red Virtual (VNet)

vnet-secure-app
10.1.0.0/16

### Subredes

| Subred | Espacio de Direcciones | Propósito |
|---------|---------|---------|
| WebSubnet | 10.1.1.0/24 | Hospedaje de las máquinas virtuales |
| AppGatewaySubnet | 10.1.2.0/24 | Hospedaje de Application Gateway |
| MgmtSubnet | 10.1.3.0/24 | Administración y gestión |

---

## Application Gateway

appgw-prod

### Funciones

- Punto de entrada de la aplicación.
- Recepción de tráfico desde Internet.
- Balanceo de solicitudes hacia los servidores web.
- Administración centralizada del tráfico HTTP.

### Componentes Configurados

- Public IP
- Frontend Configuration
- Frontend Port (80)
- HTTP Listener
- Backend Pool
- Backend HTTP Settings
- Routing Rules

---

## Máquinas Virtuales

### VM-Web-01


Ubuntu Server


Servidor web principal.

### VM-Web-02

Ubuntu Server

Servidor web secundario.

Ambas máquinas virtuales se encuentran dentro de la WebSubnet.

---

## Cuenta de Almacenamiento

stsecureapp

### Tipo de redundancia

ZRS (Zone Redundant Storage)

Proporciona almacenamiento altamente disponible para la plataforma.

---

## Azure Key Vault

kv-secure-app

Utilizado para almacenar:

- Secretos
- Contraseñas
- Configuraciones sensibles

---

## Log Analytics Workspace

law-secure-app

Responsable de:

- Recolección de logs
- Monitoreo
- Diagnóstico
- Observabilidad

---

# Seguridad de Red

## NSG-Web

Protege la WebSubnet.

### Regla SSH

| Configuración | Valor |
|------------|---------|
| Protocolo | TCP |
| Puerto | 22 |
| Origen | MgmtSubnet |
| Destino | WebSubnet |

Permite la administración de las máquinas virtuales.

---

### Regla HTTP

| Configuración | Valor |
|------------|---------|
| Protocolo | TCP |
| Puerto | 80 |
| Origen | AppGatewaySubnet |
| Destino | WebSubnet |

Permite que Application Gateway envíe tráfico hacia los servidores web.

---

## NSG-Mgmt

Protege la MgmtSubnet.

### Regla SSH

| Configuración | Valor |
|------------|---------|
| Protocolo | TCP |
| Puerto | 22 |

Permite acceso administrativo.

---

# Flujo de Tráfico

Internet
    │
    ▼
Public IP
    │
    ▼
Application Gateway
    │
 ┌──┴────────┐
 ▼           ▼
VM-Web-01  VM-Web-02

Proceso:

1. El usuario accede mediante la IP pública.
2. Application Gateway recibe la solicitud.
3. El Listener procesa la petición HTTP.
4. La Routing Rule identifica el Backend Pool.
5. La solicitud se envía a una de las máquinas virtuales.
6. Las VMs consumen servicios de almacenamiento y secretos.
7. Los registros se almacenan en Log Analytics.

---

# Estructura del Proyecto

├── main.bicep
│
├── Modules
│   ├── Network
│   │   └── main.bicep
│   │
│   ├── Compute
│   │   └── main.bicep
│   │
│   ├── Storage
│   │   └── main.bicep
│   │
│   ├── Keyvault
│   │   └── main.bicep
│   │
│   ├── Monitor
│   │   └── main.bicep
│   │
│   └── AppDefaulGateway
│       └── main.bicep
│
└── README.md

---

# Integración de Módulos

La implementación se encuentra orquestada desde:

main.bicep

## Salidas (Outputs) del módulo Network

output PublicIPId string
output appGatewaySubnetId string
output webSubId string

## Parámetros consumidos por Compute

subnetId
admin1Password
admin2Password

## Parámetros consumidos por Application Gateway

PublicIPId
appGatewaySubnetId
---

# Tecnologías Utilizadas

- Azure Bicep
- Azure Virtual Network
- Azure Application Gateway
- Azure Virtual Machines
- Azure Storage Account
- Azure Key Vault
- Azure Monitor
- Azure Log Analytics
- Git
- GitHub

---

# Objetivos de Aprendizaje

Este proyecto permitió aplicar los siguientes conceptos:

- Infraestructura como Código (IaC)
- Modularización en Azure Bicep
- Redes en Azure
- Application Gateway
- NSG y segmentación de red
- Outputs y Parameters entre módulos
- Gestión de secretos
- Control de versiones con Git
- Integración de módulos en Bicep

---

## Autor

**Andres Bernardo Chacón de la Cruz**

Trainee | Mini Proyecto 02 - Plataforma de Aplicación Segura en Azure

