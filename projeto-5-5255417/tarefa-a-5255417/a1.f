      program orbitas

      implicit real*8(a-h,o-z)

c     declara os vetores que contem os raios e velocidades
c     de cada planeta
      dimension raios(11:19),velocidades(11:19)

c     define o valor de pi
      pi = 4.0d0*datan(1.0d0)

c     preenche os vetores de raio e velocidade com o valores
c     correspondentes
      raios(11) = 0.39d0
      raios(12) = 0.72d0
      raios(13) = 1.0d0
      raios(14) = 1.52d0
      raios(15) = 5.20d0
      raios(16) = 9.24d0
      raios(17) = 19.19d0
      raios(18) = 30.06d0
      raios(19) = 39.53d0
      velocidades(11) = 2.0d0*pi*raios(11)
      velocidades(12) = 2.0d0*pi*raios(12)
      velocidades(13) = 2.0d0*pi*raios(13)
      velocidades(14) = 2.0d0*pi*raios(14)
      velocidades(15) = 2.0d0*pi*raios(15)
      velocidades(16) = 2.0d0*pi*raios(16)
      velocidades(17) = 2.0d0*pi*raios(17)
      velocidades(18) = 2.0d0*pi*raios(18)
      velocidades(19) = 2.0d0*pi*raios(19)

c     define a resultante da multiplicacao da constante gravitacional
c     pela massa do sol
      gms = 4.0d0*(pi**2.0d0)

c     abre os arquivos das coordenadas de cada planeta
      open(unit=11,file='mercurio')
      open(unit=12,file='venus')
      open(unit=13,file='terra')
      open(unit=14,file='marte')
      open(unit=15,file='jupiter')
      open(unit=16,file='saturno')
      open(unit=17,file='urano')
      open(unit=18,file='netuno')
      open(unit=19,file='plutao')

c     inicia o loop para cada planeta
      do i=14,14

c           define as coordenadas iniciais
            xi = raios(i)
            yi = 0.0d0

c           define a variavel que armazenara os coordenadas maximas
            xmax = xi
            ymax = yi

c           define o raio inicial
            raio = dsqrt(xi**2.0d0 + yi**2.0d0)

c           define a velocidade em cada coordenada
            xvelocidade = 0.0d0
            yvelocidade = velocidades(i)

c           define o intervalo de tempo utilizado
            deltat = 0.00001d0/raios(i)

c           define o tempo atual
            tempo = 0.0d0

c           escreve no arquivo a coordenada inicial
            write(i,*)xi,yi

c           realiza a interacao inicial em ambas as coorednadas
            xatual = xi + xvelocidade*deltat
            yatual = yi + yvelocidade*deltat

c           salva os valores antigos das coordenadas
            xantigo = xi
            yantigo = yi

c           (re)inicia o controlador de periodo
            icontrolador = 0

c           realiza interacoes nas coordenadas ate o planeta
c           cruzar o eixo y duas vezes (um periodo)
            do while(icontrolador.lt.2)

c                 calcula o raio atual
                  raio = dsqrt(xatual**2.0d0 + yatual**2.0d0)

c                 escreve no arquivo a coordenada atual
                  write(i,*)xatual,yatual

c                 realiza um interacao em cada coordenada
                  xproximo = 2.0d0*xatual - xantigo - gms*xatual/(raio**
     13.0d0)*(deltat**2.0d0)
                  yproximo = 2.0d0*yatual - yantigo - gms*yatual/(raio**
     13.0d0)*(deltat**2.0d0)

c                 salva os valores das coordenadas antes de altera-los
                  xantigo = xatual
                  yantigo = yatual

c                 atualiza os valores das coordenadas
                  xatual = xproximo
                  yatual = yproximo

c                 atualiza as coordenadas maximas
                  if(abs(xatual).gt.xmax)then
                        xmax = xatual
                  end if
                  if(abs(yatual).gt.ymax)then
                        ymax = yatual
                  end if

c                 atualiza o tempo
                  tempo = tempo + deltat

c                 verifica se o planeta cruzou o eixo y
c                 incrementando o controlador em caso verdadeiro
                  if((yproximo*yantigo).lt.0.0d0)then
                        icontrolador = icontrolador + 1
                  end if

            end do

c           define os semieixos maior e menor
            if(xmax.gt.ymax)then
                  emaior = xmax
                  emenor = ymax
            else
                  emaior = ymax
                  emenor = xmax
            end if

c           calcula a excentricidade
            excentricidade = dsqrt(emaior**2.0d0 - emenor**2.0d0)/emaior
            write(*,1)'A excentricidade é: ',excentricidade

      end do

1     format(a21,f5.3)

c     fecha o arquivo
      close(1)
      close(2)
      close(3)
      close(4)
      close(5)
      close(6)
      close(7)
      close(8)
      close(9)

      end program