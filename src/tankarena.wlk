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
		game.addVisual(new Borde(position = game.origin()))
	}

	method configurarTeclas() {
		// TECLAS DE DIRECCION
		keyboard.up().onPressDo({ tank.imagen("tankup_verde.png")
			tank.goup()
			tank.colisionPared()
		})
		keyboard.down().onPressDo({ tank.imagen("tankdown_verde.png")
			tank.godown()
			tank.colisionPared()
		})
		keyboard.left().onPressDo({ tank.imagen("tankleft_verde.png")
			tank.goleft()
			tank.colisionPared()
		})
		keyboard.right().onPressDo({ tank.imagen("tankright_verde.png")
			tank.goright()
			tank.colisionPared()
		})
		keyboard.w().onPressDo({ tank2.imagen("tankup_red.png")
			tank2.goup()
			tank2.colisionPared()
		})
		keyboard.s().onPressDo({ tank2.imagen("tankdown_red.png")
			tank2.godown()
			tank2.colisionPared()
		})
		keyboard.a().onPressDo({ tank2.imagen("tankleft_red.png")
			tank2.goleft()
			tank2.colisionPared()
		})
		keyboard.d().onPressDo({ tank2.imagen("tankright_red.png")
			tank2.goright()
			tank2.colisionPared()
		})
		keyboard.space().onPressDo({ tank.disparo()})
		keyboard.f().onPressDo({ tank2.disparo()})
	}

	method iniciar() {
		game.addVisual(tank)
		game.addVisual(tank2)
		game.addVisual(contador1)
		game.addVisual(contador2)
		game.whenCollideDo(tank, { elemento => self.ganoP2()})
		game.whenCollideDo(tank2, { elemento => self.ganoP1()})
		game.schedule(2000, { self.iniciarmusica()})
	}

	method iniciarmusica() {
		const ambiencesound = game.sound("ambience.mp3")
		ambiencesound.shouldLoop(true)
		ambiencesound.volume(0.8)
		ambiencesound.play()
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
		game.removeVisual(tank2)
		const explosionsound = game.sound("explosion.mp3")
		explosionsound.volume(0.3)
		explosionsound.play()
		const boom = new Explosion(position = tank2.position())
		game.addVisual(boom)
		game.schedule(2000, { game.removeVisual(ganador1)
			game.removeVisual(boom)
			self.reiniciar()
			game.addVisual(tank2)
		})
	}

	method ganoP2() {
		contador2.incrementar()
		game.addVisual(ganador2)
		game.removeVisual(tank)
		const explosionsound = game.sound("explosion.mp3")
		explosionsound.volume(0.3)
		explosionsound.play()
		const boom = new Explosion(position = tank.position())
		game.addVisual(boom)
		game.schedule(2000, { game.removeVisual(ganador2)
			game.removeVisual(boom)
			self.reiniciar()
			game.addVisual(tank)
		})
	}

}

object ganador1 {

	method position() = game.at(12, 0)

	method text() = "Gano el jugador 1"

}

object ganador2 {

	method position() = game.at(22, 0)

	method text() = "Gano el jugador 2"

}

object contador1 {

	var puntos = 0

	method incrementar() {
		game.removeVisual(self)
		puntos += 1
		game.addVisual(self)
	}

	method position() = game.at(35, 0)

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

	method position() = game.at(2, 0)

	method text() = "Score P2 = " + puntos.toString()

	method textColor() = paleta.rojo()

}

object paleta {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"

}

object tank {

	var property imagen = "tankup_verde.png"
	var property position = game.at(23, 10)
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
			const canonsound = game.sound("canon.mp3")
			canonsound.play()
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
			game.onTick(100, "impacto", { if (bala.position() == tank2.position()) {
					juego.ganoP1()
				}
			})
			game.schedule(2000, { game.removeTickEvent("trayecto")
				game.removeTickEvent("impacto")
				game.removeVisual(bala)
				const cratersound = game.sound("crater.mp3")
				cratersound.volume(0.4)
				cratersound.play()
				const hoyo = new Crater(position = bala.position())
				game.addVisual(hoyo)
				bala.position(game.origin())
				cooldown = false
			})
		}
	}

	method colisionPared() {
		if (self.position().y() == (21)) {
			position = position.down(1)
		} else if (self.position().y() == (0)) {
			position = position.up(1)
		} else if (self.position().x() == (0)) {
			position = position.right(1)
		} else if (self.position().x() == (38)) {
			position = position.left(1)
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
			const canonsound = game.sound("canon.mp3")
			canonsound.play()
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
			game.schedule(2000, { game.removeTickEvent("trayecto2")
				game.removeTickEvent("impacto2")
				game.removeVisual(bala2)
				const cratersound = game.sound("crater.mp3")
				cratersound.volume(0.4)
				cratersound.play()
				const hoyo = new Crater(position = bala2.position())
				game.addVisual(hoyo)
				bala2.position(game.origin())
				cooldown = false
			})
		}
	}

	method colisionPared() {
		if (self.position().y() == (21)) {
			position = position.down(1)
		} else if (self.position().y() == (0)) {
			position = position.up(1)
		} else if (self.position().x() == (0)) {
			position = position.right(1)
		} else if (self.position().x() == (38)) {
			position = position.left(1)
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

class Crater {

	var property position

	method image() = "crater.png"

}

class Explosion {

	var property position

	method image() = "explosion.gif"

}

