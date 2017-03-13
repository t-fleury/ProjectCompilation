ce programme  est correct


 L'arbre de syntaxe astraite: 
Mp Se Af X1 10 Wh X1 Se Af X2 * 2 + X2 1 Af X1 - X1 1 

Le code C3A: 
ET1       :Afc   :10        :          :CT2       
ET0       :Af    :X1        :CT2       :
ET3       :Sk    :          :          :X1        
ET21      :Jz    :X1        :          :ET22      
ET6       :Afc   :2         :          :CT7       
ET9       :Sk    :          :          :X2        
ET10      :Afc   :1         :          :CT11      
ET8       :Pl    :X2        :CT11      :VA12      
ET5       :Mu    :CT7       :VA12      :VA13      
ET4       :Af    :X2        :VA13      :
ET16      :Sk    :          :          :X1        
ET17      :Afc   :1         :          :CT18      
ET15      :Mo    :X1        :CT18      :VA19      
ET14      :Af    :X1        :VA19      :
ET20      :Jp    :          :          :ET3       
ET22      :Sk    :          :          :
ET23      :St    :          :          :


Le code Y86: 
                  .pos      0         #debut zone code 
INIT      :irmovl Data,     %edx      #adresse de la zone de donnees
           irmovl 256,      %eax      #espace pile
           addl   %edx,     %eax                
           rrmovl %eax,     %esp      #init pile 
           rrmovl %eax,     %ebp                
ET1       :irmovl 10,       %eax      #trad Afc    10                  CT2       
           rmmovl %eax,     28(%edx)            
ET0       :mrmovl 28(%edx), %eax      #trad Af     X1        CT2        
           rmmovl %eax,     36(%edx)            
ET3       :nop                        #trad Sk                         X1        
ET21      :mrmovl 36(%edx), %eax      #trad Jz     X1                  ET22      
           andl   %eax,     %eax                
           je     ET22                          
ET6       :irmovl 2,        %eax      #trad Afc    2                   CT7       
           rmmovl %eax,     24(%edx)            
ET9       :nop                        #trad Sk                         X2        
ET10      :irmovl 1,        %eax      #trad Afc    1                   CT11      
           rmmovl %eax,     20(%edx)            
ET8       :mrmovl 32(%edx), %eax      #trad Pl     X2        CT11      VA12      
           mrmovl 20(%edx), %ebx                
           addl   %eax,     %ebx                
           rmmovl %ebx,     16(%edx)            
ET5       :mrmovl 24(%edx), %eax      #trad Mu     CT7       VA12      VA13      
           mrmovl 16(%edx), %ebx                
           pushl  %ebx                          
           pushl  %eax                          
           call   MUL                           
           popl   %eax                          
           popl   %ebx                          
           mrmovl 0(%edx),  %eax                
           rmmovl %eax,     12(%edx)            
ET4       :mrmovl 12(%edx), %eax      #trad Af     X2        VA13       
           rmmovl %eax,     32(%edx)            
ET16      :nop                        #trad Sk                         X1        
ET17      :irmovl 1,        %eax      #trad Afc    1                   CT18      
           rmmovl %eax,     8(%edx)             
ET15      :mrmovl 36(%edx), %ebx      #trad Mo     X1        CT18      VA19      
           mrmovl 8(%edx),  %eax                
           subl   %eax,     %ebx                
           rmmovl %ebx,     4(%edx)             
ET14      :mrmovl 4(%edx),  %eax      #trad Af     X1        VA19       
           rmmovl %eax,     36(%edx)            
ET20      :jmp    ET3                 #trad Jp                         ET3       
ET22      :nop                        #trad Sk                          
ET23      :halt                       #trad St                          
MUL       :nop                        #ssprog mult:M[M[%edx]]:=X*Y
           mrmovl 4(%esp),  %eax      #A := X   
           mrmovl 8(%esp),  %ebx      # B:= Y   
           andl   %eax,     %eax      # si A==0 return 0
           je     END                           
SIGN      :nop                        #si A <= 0 alors (X:= -A,Y:= -B)
           jg     MULPLUS             #cas ou A > 0
           irmovl 0,        %ecx                
           subl   %eax,     %ecx                
           rrmovl %ecx,     %eax                
           rmmovl %eax,     4(%esp)   #X := -A  
           irmovl 0,        %ecx                
           subl   %ebx,     %ecx                
           rrmovl %ecx,     %ebx                
           rmmovl %ebx,     8(%esp)   #Y := -B  
MULPLUS   :nop                        #ssprog X>0->M[M[%edx]]:=X*Y
           mrmovl 4(%esp),  %eax      #A := X   
           andl   %eax,     %eax      # si X==0 return 0
           je     END                           
           irmovl 1,        %esi      # A:=A-1  
           subl   %esi,     %eax                
           mrmovl 8(%esp),  %ebx      # B:= Y   
           pushl  %ebx                # empiler B, puis A
           pushl  %eax                          
           call   MULPLUS             # M[%edx]:= A * B=(X-1) * Y
           popl   %eax                # depiler A puis B
           popl   %eax                          
           mrmovl 0(%edx),  %eax      # M[%edx]:= M[%edx] + Y
           mrmovl 8(%esp),  %ebx                
           addl   %ebx,     %eax                
           rmmovl %eax,     0(%edx)   #end MUL(X<>0) ret(Z)
           ret                                  
END       :irmovl 0,        %eax      #end MUL(X==0) ret(Z)
           rmmovl %eax,     0(%edx)             
           ret                                  
                  .align    8         #debut zone donnees
Data      :                                     
