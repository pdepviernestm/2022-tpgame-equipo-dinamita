import wollok.game.*
import mapa.*

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
		game.addVisual(borde0)
		
		game.addVisual(borde1)
		game.addVisual(borde2)
		game.addVisual(borde3)
		game.addVisual(borde4)
		game.addVisual(borde5)
		game.addVisual(borde6)
		game.addVisual(borde7)
		game.addVisual(borde8)
		game.addVisual(borde9)
		game.addVisual(borde10)
		game.addVisual(borde11)
		game.addVisual(borde12)
		game.addVisual(borde13)
		game.addVisual(borde14)
		game.addVisual(borde15)
		game.addVisual(borde16)
		game.addVisual(borde17)
		game.addVisual(borde18)
		game.addVisual(borde19)
		game.addVisual(borde20)
		game.addVisual(borde21)
		game.addVisual(borde22)
		game.addVisual(borde23)
		game.addVisual(borde24)
		game.addVisual(borde25)
		game.addVisual(borde26)		
		game.addVisual(borde27)
		game.addVisual(borde28)
		game.addVisual(borde29)
		game.addVisual(borde30)
		game.addVisual(borde31)
		game.addVisual(borde32)
		game.addVisual(borde33)
		game.addVisual(borde34)
		game.addVisual(borde35)
		game.addVisual(borde36)
		game.addVisual(borde37)
		game.addVisual(borde38)
		game.addVisual(borde39)
		game.addVisual(borde40)
		game.addVisual(borde41)
		game.addVisual(borde42)
		game.addVisual(borde43)
		game.addVisual(borde44)
		game.addVisual(borde45)
		game.addVisual(borde46)
		game.addVisual(borde47)
		game.addVisual(borde48)
		game.addVisual(borde49)
		game.addVisual(borde50)
		game.addVisual(borde51)
		game.addVisual(borde52)
		game.addVisual(borde53)
		game.addVisual(borde54)
		game.addVisual(borde55)
		game.addVisual(borde56)
		game.addVisual(borde57)
		game.addVisual(borde58)
		game.addVisual(borde59)
		game.addVisual(borde60)
		game.addVisual(borde61)
		game.addVisual(borde62)
		game.addVisual(borde63)
		game.addVisual(borde64)
		game.addVisual(borde65)
		game.addVisual(borde66)
		game.addVisual(borde67)
		game.addVisual(borde68)
		game.addVisual(borde69)
		game.addVisual(borde70)
		game.addVisual(borde71)
		game.addVisual(borde72)
		game.addVisual(borde73)
		game.addVisual(borde74)
		game.addVisual(borde75)
		game.addVisual(borde76)
		game.addVisual(borde77)
		game.addVisual(borde78)
		game.addVisual(borde79)
		game.addVisual(borde80)
		game.addVisual(borde81)
		game.addVisual(borde82)
		game.addVisual(borde83)
		game.addVisual(borde84)
		game.addVisual(borde85)
		game.addVisual(borde86)
		game.addVisual(borde87)
		game.addVisual(borde88)
		game.addVisual(borde89)
		game.addVisual(borde90)
		game.addVisual(borde91)
		game.addVisual(borde92)
		game.addVisual(borde93)
		game.addVisual(borde94)
		game.addVisual(borde95)
		game.addVisual(borde96)
		game.addVisual(borde97)
		game.addVisual(borde98)
		game.addVisual(borde99)
		game.addVisual(borde100)
		game.addVisual(borde101)
		game.addVisual(borde102)
		game.addVisual(borde103)
		game.addVisual(borde104)
		game.addVisual(borde105)
		game.addVisual(borde106)
		game.addVisual(borde107)
		game.addVisual(borde108)
		game.addVisual(borde109)
		game.addVisual(borde110)
		game.addVisual(borde111)
		game.addVisual(borde112)
		game.addVisual(borde113)
		game.addVisual(borde114)
		game.addVisual(borde115)
		game.addVisual(borde116)
		game.addVisual(borde117)
		game.addVisual(borde118)
		game.addVisual(borde119)
		game.addVisual(borde120)
		game.addVisual(borde121)
		game.addVisual(borde122)
		game.addVisual(borde123)
		game.addVisual(borde124)
		game.addVisual(borde125)
		
		game.addVisual(inicio)
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
	}
	
	method reiniciar() {
		tank.position(game.origin())
		tank2.position(game.origin())
		tank.imagen("tankup_verde.png")
		tank2.imagen("tankup_red.png")
	}

	method ganoP1() {
		game.addVisual(ganador1)
		game.schedule(2000, {game.removeVisual(ganador1)})
		tank2.imagen("explosion.gif")
		game.schedule(2000, {self.reiniciar()})
	}
	method ganoP2() {
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

object inicio {
	method position() = game.center()
	
	method text() = "Toca I para comenzar la partida"
}

object tank {

	var property imagen = "tankup_verde.png"
	var property position = game.origin()
	var cooldown = false
	var balas = []
	
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
			game.whenCollideDo(bala, { elemento =>
				elemento.colision()
				balas.forEach{bala => 
					game.removeVisual(bala)
					game.removeTickEvent("trayecto")
				}
				balas.clear()
			})
		}
		
	}
	
	method colision(){
		juego.ganoP2()
	}

}

object tank2 {

	var property imagen = "tankup_red.png"
	var property position = game.origin()
	var cooldown = false
	var balas = []
	
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
			game.whenCollideDo(bala2, { elemento =>
				elemento.colision()
				balas.forEach{bala => 
					game.removeVisual(bala)
					game.removeTickEvent("trayecto2")
				}
				balas.clear()
			})
		}
	}
	
	method colision(){
		juego.ganoP1()
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

}

