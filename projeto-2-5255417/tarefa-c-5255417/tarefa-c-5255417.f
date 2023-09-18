      program andarilho bebado 2d

c     cria io nome do arquivo de saída e os vetores que armazenarão a posição dos andarilhos
      character name*20
      dimension ihisto(2000,2000)

c     limpa o vetor que armazena a posição dos andarilhos
      do i=1, 2000
        do j=1,2000

          ihisto(i,j) = 0
      
        end do
      end do

c     define o número de andarilhos
      m = 1000

c     define as probabilidades      
      ap = 0.250e0

c     define o número de passos
      write(*,*) "Qual é o número de passos desejado?"
      read(*,*) n

c     define o nome do arquivo de saída
      name = 'histograma'

c     define as somas
      somar1 = 0
      somar2 = 0

c     aloca a memória para salvar os dados do histograma
      open(unit=1,file=name)

c     define o loop dos andarilhos
      do i=1,m

c       define a posição do andarilho
        ix = 1000
        iy = 1000
c       define o loop de cada andarilho
        do j=1,n
                                                 
c         define a direção do passo
          a = rand(0)
          if(a.lt.ap) then

            ix = ix+1

          else if(a.lt.2.0e0*ap) then

            ix = ix-1

          else if(a.lt.3.0e0*ap) then

            iy = iy+1

          else

            iy = iy-1

          end if

        end do

        ihisto(ix,iy) = ihisto(ix,iy) + 1
        write(1,*) ix,iy

        s = (ix-1000)**2 + (iy-1000)**2
        somar1 = somar1 + sqrt(s)
        somar2 = somar2 + s

      end do

c     fecha a unidade de memória
      close(1)

c     define as médias
      amedia1 = somar1/m
      amedia2 = (somar2- somar1**2)/m

      write(*,*) "A média do raio é:",amedia1
      write(*,*) "e o delta ao quadrado é:",amedia2
      
      end program
