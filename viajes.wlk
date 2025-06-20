class Actividad {
    method diasQueLleva()
    const property idiomas = #{}
    method implicaEsfuerzo()
    method puedeBroncearse()
    method esInteresante() = idiomas.size() > 1
    method esActividadRecomendadaPara(unSocio) = self.esInteresante() and unSocio.leAtrae(self) and !unSocio.hizoActividad(self)
}

class ViajeDePlaya inherits Actividad {
    const property largoDePlaya
    override method diasQueLleva() = largoDePlaya / 5000
    override method implicaEsfuerzo() {
        var resultado = false
        if (largoDePlaya > 1200) {
            resultado = true
        }
        return resultado
    }
    override method puedeBroncearse() = true
}

class ExcursionACiudad inherits Actividad {
    const property cantAtracciones
    override method diasQueLleva() =  cantAtracciones / 2
    override method implicaEsfuerzo() {
        var resultado = false
        if(cantAtracciones > 5 and cantAtracciones < 8) {
            resultado = true
        }
        return resultado
    }
    override method puedeBroncearse() = false
    override method esInteresante() = super() or cantAtracciones == 5
}
class ExcursionCiudadTropical inherits ExcursionACiudad {
    override method diasQueLleva() = super() + 1
    override method puedeBroncearse() = true
}
/*
una excursión a ciudad normal (no tropical) en la que se visitan 4 atracciones, lleva 2 días, no implica esfuerzo, y no sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 4 atracciones, lleva 3 días, no implica esfuerzo, y sí sirve para broncearse.
una excursión a ciudad normal (no tropical) en la que se visitan 8 atracciones, lleva 4 días, implica esfuerzo, y no sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 8 atracciones, lleva 5 días, implica esfuerzo, y sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 10 atracciones, lleva 6 días, no implica esfuerzo, y sí sirve para broncearse.
*/

class SalidaDeTrekking inherits ExcursionACiudad {
    const property kmDeSenderos
    const property diasDeSolAlAño
    override method diasQueLleva() = kmDeSenderos / 50
    override method implicaEsfuerzo() {
        var resultado = false
        if (kmDeSenderos > 80) {
            resultado = true
        }
        return resultado
    }
    override method puedeBroncearse() {
        var resultado = false
        if (diasDeSolAlAño > 100 and kmDeSenderos > 120) {
            resultado = true
        }
        return resultado
    }
    override method esInteresante() = super() and diasDeSolAlAño > 140
}


/*
una salida de 100 kilómetros a un lugar con 130 días de sol por año: lleva 2 días, implica esfuerzo, y no sirve para broncearse.
una salida de 50 kilómetros a un lugar con 240 días de sol por año: lleva 1 día, no implica esfuerzo, y sí sirve para broncearse.
una salida de 250 kilómetros a un lugar con 130 días de sol por año: lleva 5 días, implica esfuerzo, y sirve para broncearse.
*/
/*
Para las clases de gimnasia, la condición es que el socio tenga entre 20 y 30 años.
*/
class ClasesDeGimnasia inherits Actividad {
    override method idiomas() = #{"espaniol"}
    override method diasQueLleva() = 1
    override method implicaEsfuerzo() = true
    override method puedeBroncearse() = false
    override method esActividadRecomendadaPara(unSocio) = unSocio.edad() >= 20 and unSocio.edad() <= 30 
} 
class Socio {
    const actividadesRealizadas = []
    var property edad
    const property idiomas = #{}
    const property limiteDeActividades
    method esAdoradorDelSol() = actividadesRealizadas.all({actividad => actividad.puedeBroncearse()})
    method actividadesEsforzadas() = actividadesRealizadas.filter({actividad => actividad.implicaEsfuerzo()})
    method cantActividadesRealizadas() = actividadesRealizadas.size()
    method realizarActividad(unaActividad) {
        if (self.cantActividadesRealizadas() > limiteDeActividades) {
            self.error("Ya llegó al maximo de actividades que peude hacer")
        }
        actividadesRealizadas.add(unaActividad)
    }
    method hizoActividad(unaActividad) = actividadesRealizadas.contains(unaActividad)
    method leAtrae(unaActividad)
    method hablaAlMenosUnIdiomaDe(unaActividad) = self.idiomas().intersection(unaActividad.idiomas()).size() > 0
}

class SocioTranquilo inherits Socio {
    override method leAtrae(unaActividad) = unaActividad.diasQueLleva() >= 4
}
class SocioCoherente inherits Socio {
    override method leAtrae(unaActividad) = self.esAdoradorDelSol() or unaActividad.implicaEsfuerzo()
}
class SocioRelajado inherits Socio {
    override method leAtrae(unaActividad) = self.hablaAlMenosUnIdiomaDe(unaActividad)
}

/*
roque.esAdoradorDelSol() devuelve true.
roque.actividadesEsforzadas() devuelve una colección que tiene solamente el viaje de 2000 metros de playa.
si registramos que Roque realiza una clase de gimnasia, se debe generar un error.
Si Ana es una socia que hizo dos viajes iguales a los que hizo Roque, pero tiene un máximo de 3 actividades,
 entonces sí le podemos registrar una clase de gimnasia. Después de registrarla, obtenemos que Ana ya no es adoradora del sol, y su colección de actividades esforzadas incluye al viaje de 2000 metros de playa y a la clase.
*/

