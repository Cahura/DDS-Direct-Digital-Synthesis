# Manual de Usuario - Sistema DDS

## Introducción
Este manual describe cómo usar el sistema DDS (Direct Digital Synthesis) implementado en FPGA Cyclone II para generar formas de onda digitales con control de frecuencia.

## Configuración Inicial

### 1. Programación de la FPGA
1. Conecte el cable USB-Blaster a la FPGA
2. Abra Quartus II Programmer
3. Programe el archivo `DDS/output_files/DDS.sof`

### 2. Configuración del Software Nios II
1. Abra Eclipse IDE for Nios II
2. Importe el proyecto desde `UART/software/UART/`
3. Compile y ejecute el software en el procesador

### 3. Conexión UART
1. Conecte un cable serie USB-RS232 al puerto UART de la FPGA
2. Configure su terminal serie con:
   - Velocidad: 115,200 baudios
   - Bits de datos: 8
   - Paridad: Ninguna
   - Bits de parada: 1
   - Control de flujo: Ninguno

## Operación del Sistema

### Control de Frecuencia

#### Fórmula de Frecuencia
```
f_output = (FCW × f_clock) / 1024
```
Donde:
- `FCW`: Frequency Control Word (0-1023)
- `f_clock`: Frecuencia del reloj del sistema (50 MHz)
- `1024`: Resolución del acumulador (2^10)

#### Ejemplos de Configuración
| FCW Decimal | FCW Binario | Frecuencia de Salida |
|-------------|-------------|---------------------|
| 1 | 0000000001 | 48.8 Hz |
| 10 | 0000001010 | 488 Hz |
| 51 | 0000110011 | 2.49 kHz |
| 102 | 0001100110 | 4.98 kHz |
| 512 | 1000000000 | 25 kHz |
| 1023 | 1111111111 | 49.95 kHz |

#### Proceso de Configuración
1. En el terminal serie, aparecerá el mensaje:
   ```
   Ingresa un valor binario de 10 bits:
   ```
2. Escriba el valor FCW en formato binario (ej: `0000001010`)
3. Presione Enter
4. El sistema actualizará la frecuencia inmediatamente

### Selección de Forma de Onda

El sistema cuenta con 3 botones físicos para seleccionar la forma de onda:

#### Configuración de Botones
- **Botón 1**: Activa onda senoidal
  - Combinación: `sel[2:0] = "011"`
  - PIN_47=0, PIN_42=1, PIN_44=1
  
- **Botón 2**: Activa onda diente de sierra
  - Combinación: `sel[2:0] = "101"`
  - PIN_47=1, PIN_42=0, PIN_44=1
  
- **Botón 3**: Activa onda triangular
  - Combinación: `sel[2:0] = "110"`
  - PIN_47=1, PIN_42=1, PIN_44=0

#### Características de las Ondas
1. **Onda Senoidal**
   - Forma: Sinusoidal pura
   - Aplicaciones: Comunicaciones, análisis espectral
   - THD típico: < 1% (con filtro adecuado)

2. **Onda Diente de Sierra**
   - Forma: Rampa ascendente lineal
   - Aplicaciones: Barridos, osciladores
   - Linealidad: > 99%

3. **Onda Triangular**
   - Forma: Rampa ascendente y descendente
   - Aplicaciones: Testing, generación de portadoras
   - Simetría: Simétrica

## Conexión de Salida

### Configuración del Filtro RC
La salida PWM del pin `pwm_out` (PIN_40) debe conectarse a un filtro paso bajo RC:

```
PWM_OUT ──[R]──┬── SALIDA_ANALOGICA
               │
              [C]
               │
              GND
```

#### Valores Recomendados
- **Resistencia (R)**: 1kΩ - 10kΩ
- **Capacitor (C)**: 100nF - 1µF
- **Frecuencia de Corte**: `fc = 1/(2πRC)`

#### Criterio de Diseño
La frecuencia de corte del filtro debe ser:
```
fc ≥ 10 × f_output_max
```

Para f_output_max = 25 kHz:
- fc ≥ 250 kHz
- Con R = 1kΩ: C ≤ 636 nF
- **Recomendado**: R = 1kΩ, C = 100nF (fc = 1.59 MHz)

## Solución de Problemas

### Problemas Comunes

#### 1. No hay comunicación UART
**Síntomas**: No aparece prompt en terminal
**Soluciones**:
- Verificar conexión del cable serie
- Confirmar configuración del terminal (115200, 8N1)
- Revisar que el software Nios II esté ejecutándose

#### 2. Frecuencia incorrecta
**Síntomas**: Frecuencia medida no coincide con la calculada
**Soluciones**:
- Verificar formato de entrada (10 bits binarios)
- Confirmar frecuencia del reloj del sistema
- Revisar filtro RC de salida

#### 3. Forma de onda distorsionada
**Síntomas**: Señal no tiene la forma esperada
**Soluciones**:
- Verificar posición de los botones de selección
- Ajustar filtro RC de salida
- Revisar impedancia de carga

#### 4. No hay salida
**Síntomas**: Sin señal en pin de salida
**Soluciones**:
- Verificar que la FPGA esté programada
- Confirmar que el reset esté desactivado
- Revisar conexiones de alimentación

### Comandos de Diagnóstico

#### Verificación del Sistema
1. **Test de comunicación UART**:
   - Enviar cualquier comando
   - Debe responder con prompt

2. **Test de frecuencia mínima**:
   - FCW = `0000000001`
   - Medir ~48.8 Hz en salida

3. **Test de frecuencia máxima**:
   - FCW = `1111111111`
   - Medir ~49.95 kHz en salida

## Especificaciones de Rendimiento

### Limitaciones del Sistema
- **Frecuencia máxima**: 25 kHz (criterio de Nyquist)
- **Resolución de frecuencia**: 48.8 Hz
- **Jitter de fase**: < 1°
- **Tiempo de respuesta**: < 1ms

### Condiciones de Operación
- **Temperatura**: 0°C a 85°C
- **Alimentación**: 3.3V ± 5%
- **Frecuencia de reloj**: 50 MHz ± 100 ppm

## Mantenimiento

### Calibración
El sistema no requiere calibración periódica. La precisión depende únicamente de la estabilidad del oscilador de referencia.

### Actualizaciones de Software
Para actualizar el software Nios II:
1. Modificar `hello_world_small.c`
2. Recompilar en Eclipse
3. Ejecutar nueva versión

### Actualizaciones de Hardware
Para modificar la lógica FPGA:
1. Editar archivos `.vhd`
2. Recompilar en Quartus II
3. Reprogramar FPGA con nuevo archivo `.sof`
