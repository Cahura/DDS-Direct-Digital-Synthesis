# Contribuir al Proyecto DDS

¡Gracias por tu interés en contribuir al proyecto DDS (Direct Digital Synthesis)! Este documento describe cómo puedes ayudar a mejorar este sistema de generación de formas de onda.

## 🚀 Formas de Contribuir

### 1. Reportar Bugs
- Usa el sistema de Issues de GitHub
- Incluye pasos para reproducir el problema
- Especifica versión de Quartus II y hardware usado
- Adjunta archivos de log si es aplicable

### 2. Proponer Mejoras
- Nuevas formas de onda
- Optimizaciones de recursos FPGA
- Mejoras en el software Nios II
- Documentación adicional

### 3. Desarrollo de Código
- Fork del repositorio
- Crear branch para nueva característica
- Seguir estándares de codificación
- Incluir documentación
- Crear Pull Request

## 📋 Estándares de Codificación

### VHDL
```vhdl
-- Usar nombres descriptivos para señales
signal clock_enable    : std_logic;
signal frequency_word  : std_logic_vector(9 downto 0);

-- Comentarios claros para procesos complejos
process(clk, rst)
begin
    -- Descripción del proceso
    if rst = '0' then
        -- Estado de reset
    elsif rising_edge(clk) then
        -- Lógica principal
    end if;
end process;
```

### C (Nios II)
```c
// Usar nombres descriptivos para funciones
void configure_frequency_control_word(uint16_t fcw_value);

// Comentarios para funciones complejas
/**
 * Convierte string binario a valor entero FCW
 * @param binary_string: String de 10 caracteres ('0' o '1')
 * @return: Valor entero de 0-1023
 */
uint16_t convert_binary_to_fcw(char* binary_string);
```

## 🔧 Configuración del Entorno

### Requisitos
- Quartus II 13.0 o superior
- Eclipse IDE para Nios II
- Git para control de versiones
- Hardware: FPGA Cyclone II EP2C5T144C8

### Setup Inicial
```bash
# Clonar repositorio
git clone https://github.com/Cahura/DDS-Direct-Digital-Synthesis.git
cd DDS-Direct-Digital-Synthesis

# Crear branch para desarrollo
git checkout -b feature/nueva-caracteristica

# Hacer cambios y commit
git add .
git commit -m "Descripción clara del cambio"
git push origin feature/nueva-caracteristica
```

## 📝 Proceso de Pull Request

1. **Fork del repositorio**
2. **Crear branch descriptivo**
   ```bash
   git checkout -b feature/control-amplitud
   ```
3. **Desarrollar la característica**
4. **Probar exhaustivamente**
5. **Documentar cambios**
6. **Crear Pull Request**

### Template de Pull Request
```markdown
## Descripción
Breve descripción de los cambios realizados.

## Tipo de Cambio
- [ ] Bug fix
- [ ] Nueva característica
- [ ] Mejora de performance
- [ ] Documentación

## Testing
- [ ] Probado en hardware
- [ ] Simulación exitosa
- [ ] Todas las pruebas pasan

## Screenshots/Logs
(Si aplica, incluir evidencia de funcionamiento)
```

## 🧪 Testing

### Hardware Testing
- Verificar en FPGA física
- Probar todas las formas de onda
- Validar rangos de frecuencia
- Medir THD de salida

### Simulación
- ModelSim para verificación funcional
- Testbenches para cada módulo
- Timing analysis en Quartus

### Software Testing
- Probar comunicación UART
- Validar conversión FCW
- Testing de casos límite

## 📚 Documentación

### Requisitos
- Actualizar README.md si es necesario
- Documentar nuevas funciones
- Incluir diagramas si hay cambios arquitectónicos
- Actualizar USER_MANUAL.md

### Formato
- Markdown para documentación
- Comentarios en código
- Diagramas ASCII para arquitectura simple
- Archivos .png para diagramas complejos

## 🏷️ Versionado

Seguimos [Semantic Versioning](https://semver.org/):
- **MAJOR.MINOR.PATCH**
- MAJOR: Cambios incompatibles
- MINOR: Nuevas características compatibles
- PATCH: Bug fixes compatibles

## 🐛 Reporte de Issues

### Template de Bug Report
```markdown
**Descripción del Bug**
Descripción clara del problema.

**Pasos para Reproducir**
1. Configurar sistema con...
2. Ejecutar comando...
3. Observar error...

**Comportamiento Esperado**
Descripción de lo que debería ocurrir.

**Entorno**
- Quartus Version: [ej. 13.0 SP1]
- FPGA: [ej. EP2C5T144C8]
- OS: [ej. Windows 10]

**Archivos de Log**
(Adjuntar archivos relevantes)
```

### Template de Feature Request
```markdown
**Descripción de la Característica**
Descripción clara de la funcionalidad deseada.

**Justificación**
¿Por qué sería útil esta característica?

**Implementación Sugerida**
Ideas sobre cómo implementar la característica.

**Alternativas Consideradas**
Otras formas de lograr el mismo objetivo.
```

## 👥 Comunidad

### Código de Conducta
- Ser respetuoso con otros contribuidores
- Proporcionar feedback constructivo
- Ayudar a newcomers
- Mantener discusiones técnicas

### Comunicación
- Issues de GitHub para bugs y features
- Pull Request discussions para código
- README para información general

## 🎯 Roadmap

### Próximas Características
- [ ] Control de amplitud variable
- [ ] Offset de fase configurable
- [ ] Interfaz gráfica para PC
- [ ] Múltiples canales simultáneos
- [ ] Formas de onda personalizadas

### Mejoras de Performance
- [ ] Optimización de recursos FPGA
- [ ] Reducción de latencia
- [ ] Mejora de precisión de frecuencia

¡Gracias por contribuir al proyecto DDS! 🎉
