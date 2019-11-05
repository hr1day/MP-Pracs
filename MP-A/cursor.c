#include<stdio.h>
#include<conio.h>
void main()
{
	int ch,a;
	clrscr();
	do
	{
		printf("\n Enter the size of the cursor: ");
		scanf("%d",&a);
		printf("\n enter your choice \n 1. Increase \n 2. Decrease \n 3. Disable \n 4. exit \n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: asm mov cx,a;
			asm mov ah,01h;
			asm INC cl;
			asm INT 10h;
			break;

			case 2: asm mov cx,a;
			asm mov ah,01h;
			asm DEC cl;
			asm INT 10h;
			break;

			case 3:
			asm mov ah,01h;
			asm INT 10h;
			break;
		}
	}
	while(ch!=4);
}