USE std.textio.ALL;

ENTITY quark IS
END quark;

ARCHITECTURE Behavioral OF quark IS
    TYPE quark_t IS (up, down, charm, strange, top, bottom);
    -- need to define a write procedure for new type
    PROCEDURE write (l : INOUT line; quark_val : IN quark_t) IS
    BEGIN
        CASE quark_val IS
            WHEN up => write(l, STRING'("up"));
            WHEN down => write(l, STRING'("down"));
            WHEN charm => write(l, STRING'("charm"));
            WHEN strange => write(l, STRING'("strange"));
            WHEN top => write(l, STRING'("top"));
            WHEN bottom => write(l, STRING'("bottom"));
        END CASE;
    END write;
BEGIN
    testing : PROCESS IS
        VARIABLE my_line : line;
    BEGIN
        write(my_line, STRING'("quark_t'pos(strange) = "));
        write(my_line, quark_t'pos(strange));
        writeline(output, my_line);
        write(my_line, STRING'("quark_t'val(1) = "));
        write(my_line, quark_t'val(1));
        writeline(output, my_line);
        write(my_line, STRING'("quark_t'succ(charm) = "));
        write(my_line, quark_t'succ(charm));
        writeline(output, my_line);
        write(my_line, STRING'("quark_t'pred(bottom) = "));
        write(my_line, quark_t'pred(bottom));
        writeline(output, my_line);
        write(my_line, STRING'("quark_t'leftof(top) = "));
        write(my_line, quark_t'leftof(top));
        writeline(output, my_line);
        write(my_line, STRING'("quark_t'rightof(down) = "));
        write(my_line, quark_t'rightof(down));
        writeline(output, my_line);
        WAIT;
    END PROCESS;
END Behavioral; -- Behavioral