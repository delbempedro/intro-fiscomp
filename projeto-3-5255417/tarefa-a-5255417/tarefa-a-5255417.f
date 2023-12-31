      program derivada

      implicit real*8 (a-h,o-z)
      dimension val(14)
        
c     define os valores de h que serao utilizados
      val(1) = 0.5d0
      val(2) = 0.2d0
      val(3) = 0.1d0
      val(4) = 0.05d0
      val(5) = 0.01d0
      val(6) = 5*10d-4
      val(7) = 10d-4
      val(8) = 5*10d-5
      val(9) = 10d-5
      val(10) = 5*10d-6
      val(11) = 10d-6
      val(12) = 10d-7
      val(13) = 10d-8
      val(14) = 10d-9

c     abre o arquivo de saida
      open(unit=1,file='saida-5255417')

c     escreve o cabecalho da tabela
      write(1,*)'|          h                  fs3                   ff2
     1                 ft2                   fs5                 f2s5 
     2           f3as5          |'

c     loop que imprime os valores da tabela das derivadas para cada h
      do i=1,14

c       define como v o valor de h para o loop atual
        v = val(i)

c       defiene o valor real das derivadas
        d1 = 9.796782013838
        d2 = 64.098324549472
        d3 = 671.514613457866

c       escreve os valores de cada derivada para o valor corrente de h
        write(1,1) v,abs(fs3(v)-d1),abs(ff2(v)-d1),abs(ft2(v)-d1),abs(fs
     1  5(v)-d1),abs(f2s5(v)-d2),abs(f3as5(v)-d3)

      end do

c     escreve o fim da tabela
      write(1,*)'EXATO: 9.796782013838 | 9.796782013838 | 9.796782013838 | 9.7
     296782013838 | 64.098324549472 | 64.098324549472 | 671.514613457866
     3'

c     fecha o arquivo de saida
      close(1)

c     formata as escritas
1     format(7('|',f20.10),'|')

      end program

c     define a funcao de 1/2 + h
      real*8 function f(h)
      implicit real*8 (a-h,o-z)

        f = dexp( (0.5d0 + h)/2.0d0 )*dtan( 2.0d0*(0.5d0 + h) )

      end function

c     define a derivada para traz de 2 pontos
      real*8 function ft2(h)
      implicit real*8 (a-h,o-z)

        ft2 = ( f(0.0d0*h)-f(-1.0d0*h) )/h

      end function

c     define a derivada para frente de 2 pontos
      real*8 function ff2 (h)
      implicit real*8 (a-h,o-z)

        ff2 = ( f(1.0d0*h)-f(0.0d0*h) )/h

      end function

c     define a derivada simetrica de 3 pontos
      real*8 function fs3 (h)
      implicit real*8 (a-h,o-z)

        fs3 = ( f(1.0d0*h)-f(-1.0d0*h) )/(2.0d0*h)

      end function

c     define a segunda derivada simetrica de 5 pontos
      real*8 function fs5 (h)
      implicit real*8 (a-h,o-z)

        fs5 = (f(-2.0d0*h)-8.0d0*f(-1.0d0*h)+8.0d0*f(1.0d0*h)-f(2.0d0*h)
     1  )/(12.0d0*h)

      end function

c     define a segunda derivada simetrica de 5 pontos
      real*8 function f2s5 (h)
      implicit real*8 (a-h,o-z)

        f2s5 = ( -f(-2.0d0*h)+16.0d0*f(-1.0d0*h)-30.0d0*f(0.0d0*h )+16.
     1  0d0*f(1.0d0*h)-f(2.0d0*h))/(12.0d0*(h**2.0d0))

      end function

c     define a terceira derivada anti-simetrica de 5 pontos
      real*8 function f3as5 (h)
      implicit real*8 (a-h,o-z)

        f3as5 = (-f(-2.0d0*h)+2.0d0*f(-1.0d0*h)-2.0d0*f(1.0d0*h)+f(2.0d
     1  0*h) )/(2.0d0*(h**3.0d0) )

      end function
