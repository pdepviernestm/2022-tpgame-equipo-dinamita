import wollok.game.*

class Borde {

	var property position

	method image() = "wall.png"

	method colisionPared() {
	}

	method colision() {
	}

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
		23.times({ i =>
			const borde = new Borde(position = game.at(0, i - 1))
			game.addVisual(borde)
		})
		23.times({ i =>
			const borde = new Borde(position = game.at(38, i - 1))
			game.addVisual(borde)
		})
		39.times({ i =>
			const borde = new Borde(position = game.at(i - 1, 0))
			game.addVisual(borde)
		})
		39.times({ i =>
			const borde = new Borde(position = game.at(i - 1, 21))
			game.addVisual(borde)
		})
		game.addVisual(inicio)
		game.addVisual(new Borde(position = game.origin()))
	}

	method configurarTeclas() {
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
		keyboard.space().onPressDo({ tank.disparo()})
		keyboard.f().onPressDo({ tank2.disparo()})
	}

	method iniciar() {
		game.removeVisual(inicio)
		game.addVisualCharacter(tank)
		game.addVisual(tank2)
		game.addVisual(contador1)
		game.addVisual(contador2)
	}

	method reiniciar() {
		tank.position(game.at(23, 10))
		tank2.position(game.at(7, 10))
		tank.imagen("tankup_verde.png")
		tank2.imagen("tankup_red.png")
	}

	method ganoP1() {
		contador1.incrementar()
		game.addVisual(ganador1)
		game.schedule(2000, { game.removeVisual(ganador1)})
		tank2.imagen("explosion.gif")
		game.schedule(2000, { self.reiniciar()})
	}

	method ganoP2() {
		contador2.incrementar()
		game.addVisual(ganador2)
		game.schedule(2000, { game.removeVisual(ganador2)})
		tank.imagen("explosion.gif")
		game.schedule(2000, { self.reiniciar()})
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
 * class Contador {
 * 	var property puntos = 0
 * 	var position
 * 	var text
 * 	var textColor
 * 	
 * 	method incrementar() { 
 * 		game.removeVisual(self)
 * 		puntos += 1
 * 		game.addVisual(self)
 * 	}
 * }

 * const contador1 = new Contador(
 * 	position = game.at(2,19), 
 * 	text = "Score P1 = " + self.puntos(),
 * 	textColor = paleta.verde()
 * )
 */
object contador1 {

	var puntos = 0

	method incrementar() {
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}

	method position() = game.at(2, 19)

	method text() = "Score P1 = " + puntos.toString()

	method textColor() = paleta.verde()

}

object contador2 {

	var puntos = 0

	method incrementar() {
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}

	method position() = game.at(35, 19)

	method text() = "Score P2 = " + puntos.toString()

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
	var property position = game.at(23, 10)
	var cooldown = false

	method image() = imagen

	method disparo() {
		if (not cooldown) {
			cooldown = true
			const bala = new Municion(position = self.position())
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
			game.onTick(100, "impacto2", { if (bala.position() == tank2.position()) {
					juego.ganoP1()
				}
			})
			game.schedule(1000, { cooldown = false
				game.removeVisual(bala)
				game.removeTickEvent("trayecto")
			})
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
	var property position = game.at(7, 10)
	var cooldown = false

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
		if (not cooldown) {
			cooldown = true
			const bala2 = new Municion(position = self.position())
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
			game.onTick(100, "impacto2", { if (bala2.position() == tank.position()) {
					juego.ganoP2()
				}
			})
			game.schedule(1000, { cooldown = false
				game.removeVisual(bala2)
				game.removeTickEvent("trayecto2")
				game.removeTickEvent("impacto2")
			})
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

	method colisionPared() {
		game.removeVisual(self)
	}

}

