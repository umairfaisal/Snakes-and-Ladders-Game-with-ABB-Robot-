MODULE Vision

    VAR num DiceValue;
    
    PERS num DiceValDisplay;

    CONST string myjob:="Vision.job";

    VAR cameratarget VisionDice;

    CONST robtarget VisDicePick:=[[0,0,-5],[0.00180718,-0.724017,-0.689762,0.00499963],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    CONST robtarget VisAboveDicePick:=[[0,0,150],[0.00182398,-0.724007,-0.689772,0.00498561],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    CONST robtarget VisThrow:=[[84.02,-509.71,350.26],[0.265801,0.603443,0.749737,0.0556838],[-2,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    TASK PERS wobjdata wo_Vision:=[FALSE,TRUE,"",[[103.794,-502.881,116.063],[0.0228506,2.42342E-05,-3.17358E-06,-0.999739]],[[91.4945,46.4082,0],[0.999879,0,0,-0.0155449]]];

    PROC CamSet()

        CamSetProgramMode CameraStn7;

        IF CamGetLoadedJob(CameraStn7)<>myjob THEN

            CamLoadJob CameraStn7,myjob;

        ENDIF

        CamSetRunMode CameraStn7;

    ENDPROC

    PROC MoveToDetectedObject()

        CamReqImage CameraStn7;

        CamGetResult CameraStn7,VisionDice;

        wo_Vision.oframe:=VisionDice.cframe;

        DicePickandThrow;

        CamReqImage CameraStn7;

        CamGetResult CameraStn7,VisionDice;

        DiceValue:=VisionDice.val1;
        
        DiceValDisplay:=DiceValue;

    ENDPROC

    PROC DicePickandThrow()

        MoveAbsJ AbsHome,v500,z50,tool0\WObj:=wobj0;

        GripperOpenDice;

        Movej VisAboveDicePick,v500,z50,ServoGripperTCP\WObj:=wo_Vision;

        MoveL VisDicePick,v200,fine,ServoGripperTCP\WObj:=wo_Vision;

        GripperCloseDice;

        MoveL VisThrow,v200,z50,ServoGripperTCP\WObj:=wobj0;

        WaitTIme 2;

        GripperOpenDice;

        MoveL Home,v500,z50,tool0\WObj:=wobj0;

    ENDPROC

ENDMODULE
