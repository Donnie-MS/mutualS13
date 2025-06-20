class Viaje {
    method diasQueLleva()
    const property idiomasQueSeUsan
    method implicaEsfuerzo()
    method puedeBroncearse()
}

class ViajeDePlaya inherits Viaje {
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

class ExcursionACiudad inherits Viaje{
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
}
/*
una salida de 100 kilómetros a un lugar con 130 días de sol por año: lleva 2 días, implica esfuerzo, y no sirve para broncearse.
una salida de 50 kilómetros a un lugar con 240 días de sol por año: lleva 1 día, no implica esfuerzo, y sí sirve para broncearse.
una salida de 250 kilómetros a un lugar con 130 días de sol por año: lleva 5 días, implica esfuerzo, y sirve para broncearse.
*/