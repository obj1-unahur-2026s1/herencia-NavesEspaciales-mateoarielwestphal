class Nave {
  var velocidad 
  var direccion
  var combustible

  method estaTranquila() = combustible >= 4000 and velocidad <= 12000
  method escapar()
  method avisar()
  method estaDeRelajo() = self.estaTranquila() and self.tienePocaActividad()
  method tienePocaActividad() {
    return true 
  } 

  method acelerar(cuanto) {
    velocidad += 100000.min(cuanto)
  }  

  method desacelerar(cuanto) {
    velocidad -= 0.max(cuanto)
  }

  method irHaciaElSol() {
    direccion = 10 
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0 
  }

  method acercarseUnPocoAlSol() {
    direccion += 1 
  }

  method alejarseUnPocoDelSol() {
    direccion -= 1 
  }

  method cargarCombustible(cuanto) {
    combustible += cuanto
  }

  method descargarCombustible(cuanto) {
    combustible -= cuanto
  }

  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
}

class Baliza inherits Nave {
  var color
  var cambioDeColor = false 

  override method estaTranquila() = super() and color != "rojo"
  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
  override method tienePocaActividad() = not cambioDeColor


  method cambiarColorDeBaliza(nuevoColor) {
    color = nuevoColor
    cambioDeColor = true 
  }
  override method prepararViaje() {
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    super()
  }
}

class Pasajero inherits Nave {
  const pasajeros 
  var comida 
  var bebida
  var racionesServidad

  override method prepararViaje() {
    self.cargarComida(4)
    self.cargarBebida(6)
    super()
  }
  override method escapar(){
    velocidad *= 2 
  }
  override method avisar(){
    self.descargarComida(pasajeros)
    self.descargarBebida(pasajeros * 2)
  }
  override method tienePocaActividad() = racionesServidad < 50

  method pasajeros() = pasajeros  

  method cargarComida(cuanto) {
    comida += cuanto
    racionesServidad += cuanto
  }

  method descargarComida(cuanto) {
    comida -= cuanto
  }

  method cargarBebida(cuanto) {
    bebida += cuanto
  }

  method descargarBebida(cuanto) {
    bebida -= cuanto
  }

}

class Combate inherits Nave {
  var estaInvisible
  var misilesDesplegados
  const mensajes = []

  override method estaTranquila() = super() and not misilesDesplegados

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendo en mision")
    super()
  }
  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar(){
    self.emitirMensaje("amenaza recibida")
  }

  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados
  method mensajesEmitidos() = mensajes
  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method esEscueta() = mensajes.all({m => not m.size() > 30})
  method emitioMensaje(mensaje) = mensajes.contains(mensaje)     

  method ponerseVisible() {
    estaInvisible = false 
  }

  method ponerseInvisible() {
    estaInvisible = true 
  }

  method desplegarMisiles() {
    misilesDesplegados = true 
  }

  method replegarMisiles() {
    misilesDesplegados = false 
  }

  method emitirMensaje(mensaje){
    mensaje.add(mensaje)
  }
}

class Hospital inherits Pasajero {
  var preparoQuirofano

  method tieneQuirofanoPreparado() = preparoQuirofano

  override method estaTranquila() = super() and not self.tieneQuirofanoPreparado()
  override method recibirAmenaza() {
    super()
    self.prepararQuirofano()
  }

  method prepararQuirofano() {
    preparoQuirofano = true 
  }
}

class Sigilosa inherits Combate {
  override method estaTranquila() = super() and not self.estaInvisible()
  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
