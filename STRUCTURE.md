# Estructura del Proyecto DDS

```
DDS-Direct-Digital-Synthesis/
├── README.md                           # Documentación principal
├── LICENSE                             # Licencia MIT
├── .gitignore                         # Archivos a ignorar por Git
│
├── DDS/                               # Proyecto principal DDS
│   ├── DDS.qpf                        # Archivo proyecto Quartus
│   ├── DDS.qsf                        # Configuración del proyecto
│   ├── DDS.vhd                        # Entidad principal del sistema
│   ├── db/                            # Base de datos de compilación
│   ├── incremental_db/                # Compilación incremental
│   ├── output_files/                  # Archivos de salida (.sof, .pof)
│   └── simulation/                    # Archivos de simulación
│
├── Acum_Fase/                         # Acumulador de Fase
│   ├── Acum_Fase.qpf
│   ├── Acum_Fase.qsf
│   ├── Acum_Fase.vhd                  # Implementación del acumulador
│   └── [otros archivos del proyecto]
│
├── DAC/                               # Convertidor Digital-Analógico
│   ├── DAC.qpf
│   ├── DAC.qsf
│   ├── DAC.vhd                        # Generador PWM
│   └── [otros archivos del proyecto]
│
├── MUX/                               # Multiplexor de selección
│   ├── MUX.qpf
│   ├── MUX.qsf
│   ├── MUX.vhd                        # Selector de forma de onda
│   └── [otros archivos del proyecto]
│
├── Senoidal/                          # Tabla Lookup Senoidal
│   ├── Senoidal.qpf
│   ├── Senoidal.qsf
│   ├── Senoidal.vhd                   # ROM con datos sinusoidales
│   ├── senoidal.mif                   # Datos de inicialización
│   ├── Senoidal_inst.vhd              # Template de instanciación
│   └── [otros archivos del proyecto]
│
├── Triangular/                        # Tabla Lookup Triangular
│   ├── Triangular.qpf
│   ├── Triangular.qsf
│   ├── Triangular.vhd                 # ROM con datos triangulares
│   ├── triangular.mif                 # Datos de inicialización
│   ├── Triangular_inst.vhd            # Template de instanciación
│   └── [otros archivos del proyecto]
│
├── Diente_de_Sierra/                  # Tabla Lookup Diente de Sierra
│   ├── Diente_de_Sierra.qpf
│   ├── Diente_de_Sierra.qsf
│   ├── Diente_de_Sierra.vhd           # ROM con datos de rampa
│   ├── diente_de_sierra.mif           # Datos de inicialización
│   ├── Diente_de_Sierra_inst.vhd      # Template de instanciación
│   └── [otros archivos del proyecto]
│
└── UART/                              # Sistema Nios II y UART
    ├── UART.qpf
    ├── UART.qsf
    ├── UART.qsys                      # Sistema Qsys con Nios II
    ├── UART.sopcinfo                  # Información del sistema
    ├── software/                      # Software embebido
    │   ├── UART/                      # Proyecto principal C
    │   │   ├── hello_world_small.c    # Código fuente principal
    │   │   ├── Makefile               # Configuración de compilación
    │   │   ├── system/                # Archivos del sistema
    │   │   └── [otros archivos]
    │   └── UART_bsp/                  # Board Support Package
    │       └── [archivos BSP]
    └── [otros archivos del proyecto]
```

## Descripción de Componentes

### Archivos Principales
- **DDS.vhd**: Entidad top-level que interconecta todos los módulos
- **Acum_Fase.vhd**: Acumulador de fase de 10 bits con control FCW
- **DAC.vhd**: Generador PWM de 10 bits con señal de habilitación
- **MUX.vhd**: Multiplexor 3:1 para selección de forma de onda

### Tablas de Lookup (LUT)
- **Senoidal**: 1024 puntos de onda sinusoidal (0° a 360°)
- **Triangular**: 1024 puntos de onda triangular simétrica
- **Diente_de_Sierra**: 1024 puntos de rampa ascendente

### Sistema Embebido
- **UART.qsys**: Configuración del sistema Nios II con periféricos
- **hello_world_small.c**: Software de control de frecuencia vía UART
- **BSP**: Board Support Package para el sistema embebido

### Archivos de Configuración
- **.qpf**: Archivos de proyecto Quartus II
- **.qsf**: Settings y configuraciones de síntesis
- **.mif**: Memory Initialization Files para las ROMs
