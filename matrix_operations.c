#include<stdio.h>
void addition(int A[][3],int B[][3],int n);
void subtraction(int A[][3],int B[][3],int n);
void multiplication(int A[][3],int B[][3],int n);
void transpose(int A[][3],int n);
void determinant(int A[][3]);
void scaling(int A[][3],int n);
void print_matrix(int A[][3],int n);
int main()
{
	int n,i,j,choice;
	printf("Enter dimension of array=> ");
	scanf("%d",&n);
	int A[3][3],B[3][3];
	printf("Enter elements in first array\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			scanf("%d",&A[i][j]);
		}
	}
	printf("Enter elements in second array\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			scanf("%d",&B[i][j]);
		}
	}
	printf("\nFirst entered matrix is as follows:\n");
	print_matrix(A,n);
	printf("\nSecond entered matrix is as follows:\n");
	print_matrix(B,n);
	printf("\nMENU\n");
	printf("1.ADDITION\n");
	printf("2.SUBTRACTION\n");
	printf("3.MULTIPLICATION\n");
	printf("4.TRANSPOSE\n");
	printf("5.DETERMINANT\n");
	printf("6.SCALING\n");
	printf("7.EXIT\n");
	printf("Enter your choice=> ");
	scanf("%d",&choice);
	while(choice!=7){
		switch(choice){
			case 1:
				addition(A,B,n);
				break;
			case 2:
				subtraction(A,B,n);
				break;
			case 3:
				multiplication(A,B,n);
				break;
			case 4:
				transpose(A,n);
				break;
			case 5:
				determinant(A);
				break;
			case 6:
				scaling(A,n);
				break;
			default:
				printf("\nINVALID CHOICE!");
		}
		printf("\nEnter your choice=> ");
		scanf("%d",&choice);
	}
	printf("\nEXITING");
	return 0;
}
void addition(int A[][3],int B[][3],int n)
{
	int i,j,sum=0;
	printf("\nResultant matrix:\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			sum=A[i][j]+B[i][j];
			printf("%d ",sum);
		}
		printf("\n");
	}
}
void subtraction(int A[][3],int B[][3],int n)
{
	printf("\nResultant matrix:\n");
	int i,j,diff=0;
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			diff=A[i][j]-B[i][j];
			printf("%d ",diff);
		}
		printf("\n");
	}
}
void multiplication(int A[][3],int B[][3],int n)
{
	int i,j,k,sum;
	printf("\nResultant matrix:\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			sum=0;
			for(k=0;k<n;k++){
				sum+=A[i][k]*B[k][j];
			}
			printf("%d ",sum);
		}
		printf("\n");
	}
}
void transpose(int A[][3],int n)
{
	int i,j,t;
	printf("\nResultant matrix:\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			t=A[j][i];
			printf("%d ",t);
		}
		printf("\n");
	}
}
void determinant(int A[][3])
{
	int d=A[0][0]*((A[1][1]*A[2][2])-(A[2][1]*A[1][2]))-A[0][1]*((A[1][0]*A[2][2])-(A[2][0]*A[1][2]))+A[0][2]*((A[1][0]*A[2][1])-(A[2][0]*A[1][1]));
	printf("\nDeterminant result= %d",d);
}
void scaling(int A[][3],int n)
{
	int scaling_factor,scale,i,j;
	printf("Enter a number for performing scaling=> ");
	scanf("%d",&scaling_factor);
	printf("\nResultant matrix:\n");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			scale=A[i][j]*scaling_factor;
			printf("%d ",scale);
		}
		printf("\n");
	}
	
}
void print_matrix(int A[][3],int n)
{
	int i,j;
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			printf("%d ",A[i][j]);
		}
		printf("\n");
	}
}
