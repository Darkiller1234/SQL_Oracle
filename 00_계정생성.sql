/*SELECT * FROM ALL_USERS;*/



/*
  ���� ���� ���
  CREATE USER �����̸� IDENTIFIED BY ��й�ȣ;
  
  GRANT ���� TO �����̸�;
*/

CREATE USER SEMIYOON IDENTIFIED BY SEMIYOON;

-- KH������ �ּ����� ������ �ο�(����, �����Ͱ���)
GRANT CONNECT, RESOURCE TO SEMIYOON;
GRANT CREATE VIEW TO SEMIYOON;