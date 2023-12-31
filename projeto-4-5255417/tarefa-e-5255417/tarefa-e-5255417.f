      program secaodepoincare

      implicit real*8(a-h,o-z)
      dimension amplitude(2)

c     define as amplitudes da forca
      amplitude(1) = 0.5d0
      amplitude(2) = 1.2d0

c     define o valor de pi
      pi = 4.0d0*datan(1.0d0)

c     define o valores da gravidade, comprimento e massa
c     referentes ao pendulo
      g = 9.8d0
      r = 9.8d0
      am = 1.0d0

c     define a constante de amortecimento e a frequencia da forca
      gamma = 0.5d0
      frequencia = 2.0d0/3.0d0

c     inicia o valor de theta e omega de acordo com a
c     solucao analitica
      theta1 = 1.0d0*pi/6.0d0
      omega1 = 0.0d0
      theta2 = 1.001d0*pi/6.0d0
      omega2 = 0.0d0
      theta3 = 0.999d0*pi/6.0d0
      omega3 = 0.0d0

c     defini o "tempo" de analise, qual o espacamento de "tempo"
c     entre as incrementacoes em theta e omega
      tempomax = 20000.0d0
      deltat = 0.04d0

c     abre os arquivos onde serao salvas as informacoes
      open(unit=1,file="amplitude0.5-1")
      open(unit=3,file="amplitude0.5-2")
      open(unit=5,file="amplitude0.5-3")
      open(unit=2,file="amplitude1.2-1")
      open(unit=4,file="amplitude1.2-2")
      open(unit=6,file="amplitude1.2-3")

c     define o loop para cada amplitude
      do i=1,2

c           (re)define o tempo como 0
            tempo = 0.0d0

c           inicia o loop de oscilacao
            do while(tempo.lt.tempomax)

c                 define o tempo atual
                  tempo = tempo + deltat

c                 incrementa theta1 e omega1 se acordo com o metodo
c                 de euler amortecido
                  omega1 = omega1 - (g/r)*dsin(theta1)*deltat - gamma*om
     1ega1*deltat + amplitude(i)*dsin(frequencia*tempo)*deltat
                  theta1 = theta1 + omega1*deltat

c                 incrementa theta2 e omega2 se acordo com o metodo
c                 de euler amortecido
                  omega2 = omega2 - (g/r)*dsin(theta2)*deltat - gamma*om
     2ega2*deltat + amplitude(i)*dsin(frequencia*tempo)*deltat
                  theta2 = theta2 + omega2*deltat

c                 incrementa theta3 e omega3 se acordo com o metodo
c                 de euler amortecido
                  omega3 = omega3 - (g/r)*dsin(theta3)*deltat - gamma*om
     2ega3*deltat + amplitude(i)*dsin(frequencia*tempo)*deltat
                  theta3 = theta3 + omega3*deltat

                  if(mod(tempo*frequencia,pi).lt.deltat/2.0d0) then

                        write(i,*)mod(theta1,2.0d0*pi),omega1
                        write(i+2,*)mod(theta2,2.0d0*pi),omega2
                        write(i+4,*)mod(theta3,2.0d0*pi),omega3

                  end if

            end do

      end do

c     fecha os arquivos utilizados
      close(1)
      close(2)
      close(3)
      close(4)
      close(5)
      close(6)

      end program
