## Separación de Lógica de Navegación y UI

En este proyecto, la lógica de navegación se implementó utilizando **UIKit**, mientras que las vistas se desarrollaron con **SwiftUI**. Este enfoque garantiza una clara separación de responsabilidades, mejorando la modularidad y escalabilidad del proyecto.

### Razonamiento

- **UIKit:** Maneja la navegación y la coordinación entre vistas, proporcionando una estructura sólida para gestionar transiciones y flujos complejos.
- **SwiftUI:** Se encarga exclusivamente de la representación visual de los datos y la interacción con el usuario, aprovechando su enfoque declarativo y reactivo.

### Ventajas

1. **Escalabilidad:**
   - Facilita la incorporación de nuevas funcionalidades, ya que los cambios en la lógica de navegación no afectan directamente la UI.

2. **Mantenibilidad:**
   - La separación permite trabajar en la navegación y la UI de manera independiente, simplificando la gestión del código.

3. **Flexibilidad:**
   - Combina la robustez de **UIKit** para la gestión de flujos con la modernidad de **SwiftUI** para diseñar interfaces adaptativas y reactivas.

Este diseño asegura un desarrollo modular y preparado para futuras expansiones o cambios en los flujos de navegación o las interfaces de usuario.

## Arquitectura Utilizada

El proyecto implementa una arquitectura **MVVM-C (Model-View-ViewModel-Coordinator)** en combinación con los principios de **Clean Architecture** para garantizar una separación clara de responsabilidades y un diseño escalable.

### Desglose Técnico
- **MVVM-C:** 
  - **Model:** Gestiona los datos y la lógica de negocio.
  - **View:** Se encarga de la representación visual, implementada con **SwiftUI**.
  - **ViewModel:** Actúa como intermediario entre la vista y la lógica de negocio, gestionando el estado observable.
  - **Coordinator:** Maneja la navegación, desacoplando la lógica de flujo de la UI.

- **Clean Architecture:**
  - Se separan las capas en:
    - **Dominio:** Contiene los casos de uso y la lógica de negocio principal.
    - **Datos:** Maneja el acceso y la persistencia de datos (red y almacenamiento local).
    - **Presentación:** Gestiona la interacción entre la vista y los datos.
  - Cada capa interactúa únicamente a través de interfaces para garantizar la modularidad y facilidad de pruebas.

### Beneficios
- **Escalabilidad:** Estructura preparada para manejar flujos complejos.
- **Reutilización:** Componentes desacoplados y fácilmente extensibles.
- **Testabilidad:** Cada capa es independiente, lo que facilita pruebas unitarias y de integración.
