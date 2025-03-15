MODULE Service

    CONST jointtarget HomePos:=[[0,0,0,0,90,-60],[0,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget Zero:=[[0,0,0,0,0,0],[0,9E9,9E9,9E9,9E9,9E9]];

    PROC HomePosition()
        MoveAbsJ HomePos\NoEOffs,v1000,z50,tool0\WObj:=wobj0;
        
        SetGO GO_GripperAction, 0;
        
        WaitTime 1;
        
        SetGO GO_GripperAction ,9;
           
        WaitTime 0.5;
        
        Open_Gripper;
    ENDPROC

    PROC ZeroPos()
        MoveAbsJ Zero\NoEOffs,v1000,z50,tool0\WObj:=wobj0;
    ENDPROC

ENDMODULE
