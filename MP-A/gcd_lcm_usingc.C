#include <stdio.h>
#include <conio.h>

void main()
{

	int a, b, c,d;

	clrscr();
	printf("Enter the numbers:\n");
	scanf("%d%d",&a,&b);

	asm mov ax,a
	asm mov bx,b

	asm cmp ax,bx
	asm jnz label1:

	label0:
	asm mov c, ax
	printf("The GCD is %d", c);
	d=(a*b)/c;
	printf("The lcm is %d",d);
	asm jmp end

	label1:
	asm jc label2:
	asm sub ax,bx
	asm cmp ax, bx
	asm jz label0
	asm jnc label1

	label2:
	asm sub bx,ax
	asm cmp ax, bx
	asm jz label0
	asm jc label2
	asm jnc label1

	end:
	getch();

}