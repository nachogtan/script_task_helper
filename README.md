# Task Helper - SysAdmin Assistant for Linux / Asistente de Tareas SysAdmin para Linux

**Bilingual README: English / Español**

---

## 🇬🇧 English

### Overview
`task_helper.sh` is an interactive Bash script designed to help beginner and intermediate Linux users perform common system administration tasks on Debian/Ubuntu-based systems. It provides a menu-driven interface for managing files, users, groups, and basic system maintenance.

### Features
- Display Linux version and system information
- Create and edit files (nano, gedit)
- Manage users and groups
- View and link files and directories
- Assign permissions
- List processes (via `top`) and calendar
- Install essential packages and utilities
- Perform system updates and cleanup
- Restart the system or terminal

### Requirements
- Linux system based on Debian/Ubuntu (APT-based)
- `sudo` permissions for system administration tasks
- Bash shell

### Installation
Clone this repository:

```bash
git clone https://github.com/yourusername/task_helper.git
cd task_helper
chmod +x task_helper.sh
```

### Usage

Run the script:

```bash
./task_helper.sh
```

### Optional flags (for CI/CD or non-interactive runs):
```bash
--non-interactive | --ci   # Prints basic system info and exits
--version                  # Shows script version
--help, -h                 # Displays help
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first.

---

## 🇪🇸 Español
### Resumen

task_helper.sh es un script interactivo en Bash diseñado para ayudar a usuarios principiantes e intermedios de Linux a realizar tareas comunes de administración de sistemas en entornos basados en Debian/Ubuntu. Proporciona un menú para gestionar archivos, usuarios, grupos y mantenimiento básico del sistema.

### Características
- Mostrar versión de Linux e información del sistema
- Crear y editar archivos (nano, gedit)
- Gestionar usuarios y grupos
- Visualizar y vincular archivos y directorios
- Asignar permisos
- Listar procesos (con top) y calendario
- Instalar paquetes y utilidades esenciales
- Actualizar y limpiar el sistema
- Reiniciar sistema o terminal

### Requisitos
- Sistema Linux basado en Debian/Ubuntu (APT-based)
- Permisos sudo para tareas administrativas
- Bash shell

### Instalación
Clona este repositorio:

```bash
git clone https://github.com/yourusername/task_helper.git
cd task_helper
chmod +x task_helper.sh
```

### Uso
Ejecuta el script:
```bash
./task_helper.sh
```
### Flags opcionales (para CI/CD o ejecución no interactiva):
```bash
--non-interactive | --ci   # Imprime información básica del sistema y sale
--version                  # Muestra versión del script
--help, -h                 # Muestra ayuda
```

## Contributing
Pull requests son bienvenidas. Para cambios mayores, abre un issue primero.
