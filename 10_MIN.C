#include<stdio.h>
#include<conio.h>
void main()
{
 int min, num, len, i;
 clrscr();
 printf("\nEnter the length of the array: ");
 scanf("%d", &len);
 asm mov si, 1000h
 for(i=1; i<=len; i++)
 {
 printf("\nEnter the number: ");
 scanf("%d", &num);
 asm mov ax, num
 asm mov [si], ax
 if(i==1)
 {
  asm mov bx, [si]
  asm mov min, bx
  asm inc si
 }
 else
 {
  asm mov bx, min
  asm mov ax, [si]
  asm cmp bx, ax
  asm jc A
  asm mov min, ax
  asm jmp B
  A: asm mov min, bx
  B: asm inc si
  asm mov a, ax;
  asm mov b, bx;
 }
 }
 printf("\nMinimum is: %d", min);
 getch();
}

