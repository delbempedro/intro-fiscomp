      program amortecido

      implicit real*8(a-h,o-z)

c     define o valor de pi
      pi = 4.0d0*datan(1.0d0)

c     define o valores da gravidade, comprimento e massa
c     referentes ao pendulo
      g = 9.8d0
      r = 9.8d0
      m = 1.0d0

c     define a constante de amortecimento
      gamma = 0.5d0

c     inicia o valor de theta e omega
      theta = pi/6.0d0
      omega = 0.0d0

c     defini o "tempo" de analise, qual o espacamento de "tempo"
c     entre as incrementacoes em theta e omega e o tempo inical
      tempomax = 80.0d0
      deltat = 0.04d0
      tempo = 0.0d0

c     abre os arquivos onde serao salvas as informacoes
      open(unit=1,file="amortecido")

c     inicia o loop de oscilacao
      do while(tempo.lt.tempomax)

c           define o tempo atual
            tempo = tempo + deltat

c           incrementa theta e omega se acordo com o metodo
c           de euler amortecido
            omega = omega - (g/r)*theta*deltat - gamma*omega*deltat
            theta = theta + omega*deltat

c           escreve o theta(tempo) atual no arquivo e se theta passar,
c           em modulo, de 2pi - faz a carrecao adequada
            if(abs(theta).ge.2.0d0*pi) then
                  write(1,*)tempo,mod(theta,2.0d0*pi)
            else
                  write(1,*)tempo,theta
            end if 

      end do

c     fecha os arquivos utilizados
      close(1)

      end program