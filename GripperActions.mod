MODULE GripperActions

    ! Variables Declarations

    !Variable to set the value of gripper opening position (Not Less Than 20)	
    VAR num GripperOpenPositon:=20;

    !Variable to set the gripper closing position (215 Max)    
    VAR Num GripperClosePosition:=215;

    !Variable to check gripper is open or closed
    VAR num GripperClose;

    !SERVO Positions

    CONST Num GripperOpenPos:=20;
    CONST Num GripperOpenDicePos:=60;
    CONST Num GripperDiceClosePos:=100;
    CONST Num GripperPawnClosePos:=148;
    CONST Num GripperPawnOpenPos:=100;
    CONST Num GripperPencilClosePos:=205;


    PROC GripperOpen()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperOpenPos;
        WaitGI GI_GripperPositionFB,GripperOpenPos;
        GripperClose:=0;
    ENDPROC

    PROC GripperOpenDice()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperOpenDicePos;
        WaitGI GI_GripperPositionFB,GripperOpenDicePos;
        GripperClose:=0;
    ENDPROC

    PROC GripperCloseDice()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperDiceClosePos;
        WaitGI GI_GripperPositionFB,GripperDiceClosePos;
    ENDPROC

    PROC GripperClosePawn()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperPawnClosePos;
        WaitGI GI_GripperPositionFB,GripperPawnClosePos;
    ENDPROC

    PROC GripperClosePencil()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperPencilClosePos;
        WaitGI GI_GripperPositionFB,GripperPencilClosePos;
        GripperClose:=1;
    ENDPROC
    
        PROC GripperOpenPawn()
        SetGo GO_GripperSpeed,100;
        SetGo GO_GripperAction,9;
        WaitTime 0.5;
        SetGO GO_GripperPosition,GripperPawnOpenPos;
        WaitGI GI_GripperPositionFB,GripperPawnOpenPos;
        GripperClose:=0;
    ENDPROC

ENDMODULE