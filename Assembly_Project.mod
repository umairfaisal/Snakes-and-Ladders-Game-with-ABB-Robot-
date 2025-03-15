MODULE Assembly_Project
!    CONST jointtarget jpos102:=[[-9.2493,37.9557,25.2265,0.000512002,26.8265,200],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST jointtarget jpos20:=[[-9.24825,37.9559,25.2267,0.000799226,26.8258,304.032],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST jointtarget jpos30:=[[-8.73887,40.5019,24.4176,0.000799226,25.091,80.2488],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST robtarget HomeScrew:=[[351.00,0.01,709.10],[3.68846E-06,-0.500008,0.866021,3.02976E-06],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

!    CONST jointtarget jpos40:=[[-8.73959,38.2444,24.6194,0.000224777,27.1449,165],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];



!    VAR Num GripperOpen_Pos1:=50;
!    VAR Num GripperClose_Pos1:=150;
!    VAR Num Gripper_Closed;

!    PERS robtarget mytarget;

!    PERS jointtarget Addition_Jpos20;
!    CONST robtarget rpos1:=[[405.75,-66.09,298.78],[4.58749E-05,0.679691,-0.733499,-5.70859E-05],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST robtarget rpos2:=[[405.75,-66.09,298.78],[4.58749E-05,0.679691,-0.733499,-5.70859E-05],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST robtarget rabovepos12:=[[405.73,-66.09,359.24],[4.44556E-05,0.679686,-0.733503,-5.47604E-05],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

!    !    PROC Calculation()
!    !        UnGrip;
!    !        Grip;
!    !        MoveAbsJ jpos20,v1000,fine,tool0;
!    !        UnGrip;
!    !        Addition_Jpos20:=jpos20;
!    !        !  Addition_Jpos20.trans.z:=Addition_Jpos20.trans.z+2;

!    !        !mytarget:=myRobtarget;
!    !        !  mytarget.trans.z:=mytarget.trans.z+4;
!    !    ENDPROC

!    PROC UnGrip2()
!        SetGo GO_GripperAction,9;
!        SetGo GO_GripperSpeed,255;
!        WaitTime 0.5;
!        SetGO GO_GripperPosition,GripperOpen_Pos1;
!        WaitGI GI_GripperPositionFB,GripperOpen_Pos1;
!    ENDPROC

!    PROC Grip2()

!        SetGo GO_GripperAction,9;
!        SetGo GO_GripperSpeed,255;
!        WaitTime 0.5;
!        SetGO GO_GripperPosition,GripperClose_Pos1;
!        WaitGI GI_GripperPositionFB,GripperClose_Pos1;


!    ENDPROC

!    PROC screw()
!        !  MoveJ p10,v1000,fine,tool0;
!        !TPWrite "Rotation of position1:";
!        ! MoveJ p20,v1000,fine,tool0;
!        UnGrip;

!        MoveL HomeScrew,v1000,z50,tool0\WObj:=wobj0;
!        MoveL rabovepos1,v1000,fine,tool0\WObj:=wobj0;
!        MoveL rpos1,v1000,fine,tool0\WObj:=wobj0;
!        Grip;
!        MoveAbsJ jpos10,v1000,fine,tool0;
!        UnGrip;
!        MoveL rpos1,v1000,fine,tool0\WObj:=wobj0;

!        !New position to hold peg(Update when you take positions)
!        MoveL rpos2,v1000,fine,tool0\WObj:=wobj0;
!        Grip;
!        MoveAbsJ jpos10,v1000,fine,tool0;
!        UnGrip;
!        MoveL rpos1,v1000,fine,tool0\WObj:=wobj0;

!        !New position to hold peg(Update when you take positions)
!        MoveL rpos2,v1000,fine,tool0\WObj:=wobj0;
!        Grip;
!        MoveAbsJ jpos10,v1000,fine,tool0;
!        UnGrip;
!        MoveL rpos1,v1000,fine,tool0\WObj:=wobj0;
!    ENDPROC


ENDMODULE