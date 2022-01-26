#  PaymentApp

Está basado en la arquitectura MVVM, con ciertas adaptaciones.

## Estructura de paquetes

Se definió la siguiente taxonomía de paquetes:

    * **Model** Representa la capa de modelo de datos.
    * **View** Representa la información de la app a través de elementos visuales, contiene comportamientos de la vista, eventos y comunicación con el ViewModel.
    * **ViewModel** Es un actor intermediario entre el modelo y la vista, tiene comunicación con la capa Service.
    * **Service** Representa la capa que se comunica con fuentes de datos externos o internos.
    
## Dependencias
    * **Alamofire**
 
 ## Extra
    * Se detecta inconsistencia en imagen de logos de los bancos y son reemplazados por una imágen de referencia estática.
