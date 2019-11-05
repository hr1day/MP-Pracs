#include<stdio.h>
#include<conio.h>
void main()
{
	int i,len,num,max;
	clrscr();
	printf("Enter Size of Array: ");
	scanf("%d",&len);
	max=0;
	asm mov si, 1000h
	for(i=0; i<len; i++)
	{
		printf("Enter Element: ");
		scanf("%d",&num);
		asm mov ax, num
		asm mov [si], ax
		asm inc si
		asm inc si
	}
	asm mov si, 1000h
	asm mov bx, [si]
	asm mov max, bx
	asm mov cx, 0000h
	asm mov cx, len
	asm dec cx
	asm inc si
	asm inc si
	labelloop:
		
		asm mov ax, 0000h
		asm mov ax, [si]
		asm cmp max, ax
		asm jnc labelB
		labelA:
			asm mov max, ax
		labelB:
			asm inc si
			asm inc si
		asm loop labelloop
	printf("maximum is: %d", max);
	getch();
}