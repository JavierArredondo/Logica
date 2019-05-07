Autores:

 - Javier Arredondo
 - Cristian Espinoza

# Taller 1: Aplicación de LPO en la vida diaria
A diario, se realizan diversos tipos de actividades las cuales resultan muchas veces parte de nuestra rutina. Así, el desarrollo tecnológico y la producción en masa ha permitido desarrollar diversos equipos electrónicos, abajocosto, capaces de realizar estas actividades en unos cuantos minutos con tan solo presionar unbotón. Sin embargo, el desarrollo y popularidad de estos equipos viene dado no sólo por resultar prácticos y fáciles de usar, sino que también por ser capaces de generar un producto similar al desarrollado por un ser humano. Esta última característica hace que determinados aparatos eléctricos evolucionen con mayor rapidez en el mercado, siendo uno de estos lasmáquinas para preparar bebidas de infusión tan complejas como el café. 
La amplia variedad de cafeteras eléctricas que existe en el mercado permite realizar desde una simple taza de café filtrado hasta preparaciones que incluyen además de café, leche, chocolate y otros elementos utilizados en la preparación de bebidas más sofisticadas. La popularidad de este tipo de máquinas ha hecho que estén presentes en una gran cantidad de lugares, permitiendo a sus usuarios seleccionar según su preferencia tanto el sabor desu bebida así como su tamaño, pudiendo escoger sabores tales como:

- Espresso
- Americano
- Latte
- Mocca
- Macchiato
- Capuccino
- etc

Estos programas realizan las combinaciones pertinentes de cada ingrediente para poder realizar los diferentes tipos de café, los cuales otorgan las características de cada uno, como el sabor y la intensidad de estos.

## Objetivo: 
El objetivo de este taller es modelar la selección de café usando Prolog. Este modelo debe permitir la preparación de 6 tipos de café como mínimo.

Se utilizan distintas especies de granos de café, las cuales cada una tiene particularidades que son consideradas para preparar este bebestible. En el mercado se utilizan 3 tipos de café en las que se diferencian principalmente en la intensidad del sabor, los cuales son:

- Arábica: Esta especie proveniente de Etiopía es una de la más utilizada en preparar esta bebida caliente, ya que su **suave intensidad** y gran aroma la hace muy querida por los fanáticos del café.
- Robusta: A diferencia de la variedad anterior, esta variedad es conocida por su gran nivel de cafeína, por lo que su sabor es **muy intenso**, además de ser la segunda variedad más utilizada en el mercado.
- Combinado: Esta variedad es una mezcla de las dos variedades anteriores, dando como resultado un término **medio en su intensidad**.
- Descafeinado: Esta variedad de café se le realiza un proceso de lavado para eliminar gran parte de la cafeína que contiene los granos, comúnmente se utiliza el tipo Arábica para obtener esta variedad. **Suave intensidad**.

Además, para preparar un café existen varios tipos de preparación, los cuales utilizan distintas proporciones de sus ingredientes y que dan como resultado los distintos sabores que se mencionaron anteriormente. Las preparaciones de cada café son:

 - Espresso: Por cada 7 gr de café, 30 ml de agua 
 - Americano: Por cada 7 gr de café, 60 ml de agua 
 - Cortado: Por cada 7 gr de café, 3 gr de leche y 50 ml de agua 
 - Capuccino: Por cada 7 gr de café, 19 gr de leche y 150 ml de agua
 - Latte: Por cada 7 gr de café, 9 gr de leche y 90 ml de agua
 - Mokaccino: Por cada 7 gr de café, 9 gr de leche, 3 gr de chocolate en polvo y 100 ml de agua

Cabe mencionar que para una buena preparación del café la temperatura ideal es de 80°C y una presión de 9 bar ( la presión es para que exista un buen flujo de agua). Ya que se necesita una temperatura de 80°C para la preparación ideal del café, se requiere conocer la estación del año en la que se está, debido a que la temperatura ambiental afecta al tiempo en que las cafeteras calienten el agua, por lo que se debe considerar los siguientes tiempos para las preparaciones: 
- Verano: 1 minuto por taza de café
- Primavera y Otoño : 1 minuto y medio por taza de café
- Invierno: 2 minutos por taza de café

### Se deben implementar las siguientes consultas a la base de conocimiento

 1. prepararCafe(TamañoTaza, TipoPreparacion, TipoCafe, EstacionAño, Salida).
 2. cantidadTazas(TamañoTaza,TipoPreparacion,TipoCafe,EstacionAño, CantidadCafe, CantidadLeche, CantidadAgua, Salida).
 3. sePuedeUsar(Instalada, CantidadAgua, CantidadCafe, CantidadLeche).
 4. intensidadCafe(TipoCafe, TipoPreparacion, Salida).
