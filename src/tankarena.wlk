import wollok.game.*

class Borde{
	
	var property position
	method image() = "wall.png"
	
	method inicializarColision() {
		game.whenCollideDo(self, {element => element.colisionPared()} )
	}
	method colisionPared() {}
	method colision() {}
}

object juego {

	method configurar() {
		game.width(39)
		game.height(22)
		game.cellSize(30)
		game.ground("background.png")
		game.title("Tank Trouble")
	}

	method iniciarMapa() {
		// TABLERO
		
		23.times({i=> 
			const borde = new Borde(position = game.at(0, i-1))
			game.addVisual(borde)
			borde.inicializarColision()		
		})
		23.times({i=> 
			const borde = new Borde(position = game.at(38, i-1))
			game.addVisual(borde)	
			borde.inicializarColision()		
		})		
		39.times({i=> 
			const borde = new Borde(position = game.at(i-1, 0))
			game.addVisual(borde)	
			borde.inicializarColision()		
		})	
		39.times({i=> 
			const borde = new Borde(position = game.at(i-1, 21))
			game.addVisual(borde)
			borde.inicializarColision()			
		})		

		game.addVisual(inicio)
		
		game.addVisual(new Borde(position = game.origin()))
	}

	method configurarTeclas() {
		
		keyboard.i().onPressDo({ self.iniciar() })
		// TECLAS DE DIRECCION
		keyboard.up().onPressDo({ tank.imagen("tankup_verde.png")})
		keyboard.down().onPressDo({ tank.imagen("tankdown_verde.png")})
		keyboard.left().onPressDo({ tank.imagen("tankleft_verde.png")})
		keyboard.right().onPressDo({ tank.imagen("tankright_verde.png")})

		keyboard.w().onPressDo({ tank2.imagen("tankup_red.png")
			tank2.goup()
		})
		keyboard.s().onPressDo({ tank2.imagen("tankdown_red.png")
			tank2.godown()
		})
		keyboard.a().onPressDo({ tank2.imagen("tankleft_red.png")
			tank2.goleft()
		})
		keyboard.d().onPressDo({ tank2.imagen("tankright_red.png")
			tank2.goright()
		})
		keyboard.enter().onPressDo({ tank.disparo()})
		keyboard.space().onPressDo({ tank2.disparo()})
	}
	
	method iniciar() {
		game.removeVisual(inicio)
		game.addVisualCharacter(tank)
		game.addVisual(tank2)
		game.addVisual(contador1)
		game.addVisual(contador2)
	}
	
	method reiniciar() {
		tank.position(game.origin())
		tank2.position(game.origin())
		tank.imagen("tankup_verde.png")
		tank2.imagen("tankup_red.png")
	}

	method ganoP1() {
		contador1.incrementar()
		game.addVisual(ganador1)
		game.schedule(2000, {game.removeVisual(ganador1)})
		tank2.imagen("explosion.gif")
		game.schedule(2000, {self.reiniciar()})
	}
	method ganoP2() {
		contador2.incrementar()
		game.addVisual(ganador2)
		game.schedule(2000, {game.removeVisual(ganador2)})
		tank.imagen("explosion.gif")
		game.schedule(2000, {self.reiniciar()})
	}
}

object ganador1 {

	method position() = game.center()

	method text() = "Gano el jugador 1"
}

object ganador2 {

	method position() = game.center()

	method text() = "Gano el jugador 2"
}
// Intente usar clases, pero me da problemas la variable "puntos" en text
/*
class Contador {
	var property puntos = 0
	var position
	var text
	var textColor
	
	method incrementar() { 
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}
}

const contador1 = new Contador(
	position = game.at(2,19), 
	text = "Score P1 = " + self.puntos(),
	textColor = paleta.verde()
)
*/

object contador1 {
	var puntos = 0
	method incrementar() { 
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}
	
	method position() = game.at(2,19)
	method text() = "Score P1 = " + puntos
	method textColor() = paleta.verde()
}

object contador2 {
	var puntos = 0
	method incrementar() { 
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}
	
	method position() = game.at(35,19)
	method text() = "Score P2 = " + puntos
	method textColor() = paleta.rojo()
}

object paleta {
	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
}

object inicio {
	method position() = game.center()
	
	method text() = "Toca I para comenzar la partida"
}

object tank {

	var property imagen = "tankup_verde.png"
	var property position = game.at(7,10)
	var cooldown = false
	const balas = []
	
	method image() = imagen

	method disparo() {
		
		
		if(cooldown == false) {
			cooldown = true
			game.schedule(1000, {cooldown = false})
			const bala = new Municion(position = self.position())
			balas.add(bala)
			game.addVisual(bala)
			if (imagen == "tankup_verde.png") {
				bala.goup()
				game.onTick(100, "trayecto", { bala.goup()})
			} else if (imagen == "tankdown_verde.png") {
				bala.godown()
				game.onTick(100, "trayecto", { bala.godown()})
			} else if (imagen == "tankright_verde.png") {
				bala.goright()
				game.onTick(100, "trayecto", { bala.goright()})
			} else {
				bala.goleft()
				game.onTick(100, "trayecto", { bala.goleft()})
			}
			game.whenCollideDo(bala, { elemento => elemento.colision()} )
		}
		
	}
	
	method colision(){
		self.eliminarBalas()
		tank2.eliminarBalas()
		juego.ganoP2()
	}
	
	method eliminarBalas() {
		if(not balas.isEmpty())
		{
			balas.forEach{bala => game.removeVisual(bala) }
			balas.clear()
		}
	}
	
	method colisionPared() {
		if (imagen == "tankup_verde.png") {
				position = position.down(1)
			} else if (imagen == "tankdown_verde.png") {
				position = position.up(1)
			} else if (imagen == "tankright_verde.png") {
				position = position.left(1)
			} else {
				position = position.right(1)
			}
	}
	
}

object tank2 {

	var property imagen = "tankup_red.png"
	var property position = game.at(14,10)
	var cooldown = false
	const balas = []
	
	method image() = imagen

	method goup() {
		position = position.up(1)
	}

	method godown() {
		position = position.down(1)
	}

	method goright() {
		position = position.right(1)
	}

	method goleft() {
		position = position.left(1)
	}

	method disparo() {
		
		
		if(cooldown == false) {
			cooldown = true
			game.schedule(1000, {cooldown = false})
			const bala2 = new Municion(position = self.position())
			balas.add(bala2)
			game.addVisual(bala2)	
			if (imagen == "tankup_red.png") {
				bala2.goup()
				game.onTick(100, "trayecto2", { bala2.goup()})
			} else if (imagen == "tankdown_red.png") {
				bala2.godown()
				game.onTick(100, "trayecto2", { bala2.godown()})
			} else if (imagen == "tankright_red.png") {
				bala2.goright()
				game.onTick(100, "trayecto2", { bala2.goright()})
			} else {
				bala2.goleft()
				game.onTick(100, "trayecto2", { bala2.goleft()})
			}
			game.whenCollideDo(bala2, { elemento => elemento.colision()} )
		}
	}
	
	method colision(){
		self.eliminarBalas()
		tank.eliminarBalas()
		juego.ganoP1()
	}
	
	method eliminarBalas() {
		if(not balas.isEmpty())
		{
			balas.forEach{bala => game.removeVisual(bala) }
			balas.clear()
		}
	}
	
	method colisionPared() {
		if (imagen == "tankup_red.png") {
				self.godown()
			} else if (imagen == "tankdown_red.png") {
				self.goup()
			} else if (imagen == "tankright_red.png") {
				self.goleft()
			} else {
				self.goright()
			}
	}

}

class Municion {

	var property position

	method image() = "bullet.png"

	method goup() {
		position = position.up(1)
	}

	method godown() {
		position = position.down(1)
	}

	method goright() {
		position = position.right(1)
	}

	method goleft() {
		position = position.left(1)
	}
	
	method colisionPared() { game.removeVisual(self) }

}

