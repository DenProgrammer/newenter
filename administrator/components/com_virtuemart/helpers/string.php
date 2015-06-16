<?php

//-----------------------------------------------------------------------
/* set as constants */
define('GENMASCULINE', 'genMasculine', false);
define('GENNEUTER', 'genNeuter', false);
define('GENFEMININE', 'genFeminine', false);

//-----------------------------------------------------------------------
//********************************************
//-----------------------------------------------------------------------
/* declaraited functions */
function mod($a, $b) {
    return $a % $b;
}

function div($a, $b) {
    return floor($a / $b);
}

function Trunc($a) {
    return div($a, 1);
}

function Frac($a) {
    $out = explode('.', $a);
    return isset($out[1]) ? $out[1] : null;
}

function FreeZero($a) {
    $s     = '';
    $s_len = strlen($a);
    while ($s_len >= 0) {
        if (substr($a, $s_len, 1) == 0) {
            $s_len--;
        } else {
            $s = substr($a, 0, $s_len + 1);
            break;
        }
    }
    return $s;
}

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
/* class as convert data */
class NumberAnaliz {
    /* constants of rules */

    var $WD_EMPTY    = array(
        'Gender' => GENMASCULINE,
        'Base'   => '',
        'End1'   => '',
        'End2'   => '',
        'End5'   => '',
    );
    var $WD_THOUSEND = array(
        'Gender' => GENFEMININE,
        'Base'   => 'тысяч',
        'End1'   => 'а',
        'End2'   => 'и',
        'End5'   => '',
    );
    var $WD_MILLION  = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'миллион',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
    var $WD_MILLIARD = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'миллиард',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
    var $WD_INT   = array(
        'Gender' => GENFEMININE,
        'Base'   => 'цел',
        'End1'   => 'ая',
        'End2'   => 'ых',
        'End5'   => 'ых',
    );
    var $WD_FRAC  = array(
        1 =>
        array(
            'Gender' => GENFEMININE,
            'Base'   => 'десят',
            'End1'   => 'ая',
            'End2'   => 'ых',
            'End5'   => 'ых',
        ),
        2 =>
        array(
            'Gender' => GENFEMININE,
            'Base'   => 'coт',
            'End1'   => 'ая',
            'End2'   => 'ых',
            'End5'   => 'ых',
        ),
        3 =>
        array(
            'Gender' => GENFEMININE,
            'Base'   => 'тысячн',
            'End1'   => 'ая',
            'End2'   => 'ых',
            'End5'   => 'ых',
        ),
        4 =>
        array(
            'Gender' => GENFEMININE,
            'Base'   => 'десятитысячн',
            'End1'   => 'ая',
            'End2'   => 'ых',
            'End5'   => 'ых',
        ),
    );
//********************************************
    /* Рубли, копейки */
    var $WD_RUBLE = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'рубл',
        'End1'   => 'ь',
        'End2'   => 'я',
        'End5'   => 'ей',
    );
    var $WD_KOPECK = array(
        'Gender' => GENFEMININE,
        'Base'   => 'копе',
        'End1'   => 'йка',
        'End2'   => 'йки',
        'End5'   => 'ек',
    );
//********************************************
    /* Сомы, тыйыны */
    var $WD_SOM    = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'сом',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
    var $WD_TIYIN = array(
        'Gender' => GENFEMININE,
        'Base'   => 'тыйын',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
//********************************************
    /* Доллары, центы */
    var $WD_USD   = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'доллар',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
    var $WD_CENT       = array(
        'Gender' => GENMASCULINE,
        'Base'   => 'цент',
        'End1'   => '',
        'End2'   => 'а',
        'End5'   => 'ов',
    );
    private $FFirstLevel  = 0;
    private $FSecondLevel = 0;
    private $FThirdLevel  = 0;
    var $UnitWord = array('Gender' => GENNEUTER, 'Base' => '', 'End1' => '', 'End2' => '', 'End5' => '',);
    var $FNumber  = 0;

    function Levels($I) {
        switch ($I) {
            case 1: return $this->FFirstLevel;
            case 2: return $this->FSecondLevel;
            case 3: return $this->FThirdLevel;
        }
    }

    function SetNumber($AValue) {
        if ($this->FNumber != $AValue) {
            $this->FNumber      = $AValue;
            $this->FFirstLevel  = mod($this->FNumber, 10);
            $this->FSecondLevel = mod(div($this->FNumber, 10), 10);
            $this->FThirdLevel  = mod(div($this->FNumber, 100), 10);
            if ($this->FSecondLevel == 1) {
                $this->FFirstLevel  = $this->FFirstLevel + 10;
                $this->FSecondLevel = 0;
            }
        }
    }

    private function GetNumberInWord($N, $Level) {
        if ($Level == 1) {
            switch ($N) {
                case 0: return '';
                case 1: if ($this->Gender() == GENMASCULINE) {
                        return 'один';
                    } else if ($this->Gender() == GENFEMININE) {
                        return 'одна';
                    } else if ($this->Gender() == GENNEUTER) {
                        return 'один';
                    }
                case 2: if ($this->Gender() == GENMASCULINE) {
                        return 'два';
                    } else if ($this->Gender() == GENFEMININE) {
                        return 'две';
                    } else if ($this->Gender() == GENNEUTER) {
                        return 'два';
                    }
                case 3: return 'три';
                case 4: return 'четыре';
                case 5: return 'пять';
                case 6: return 'шесть';
                case 7: return 'семь';
                case 8: return 'восемь';
                case 9: return 'девять';
                case 10: return 'десять';
                case 11: return 'одиннадцать';
                case 12: return 'двенадцать';
                case 13: return 'тринадцать';
                case 14: return 'четырнадцать';
                case 15: return 'пятнадцать';
                case 16: return 'шестнадцать';
                case 17: return 'семнадцать';
                case 18: return 'восемнадцать';
                case 19: return 'девятнадцать';
            }//switch
        }//level 1
        else if ($Level == 2) {
            switch ($N) {
                case 0: return '';
                case 1: return 'десять';
                case 2: return 'двадцать';
                case 3: return 'тридцать';
                case 4: return 'сорок';
                case 5: return 'пятьдесят';
                case 6: return 'шестьдесят';
                case 7: return 'семьдесят';
                case 8: return 'восемьдесят';
                case 9: return 'девяносто';
            }
        }//level 2
        else if ($Level == 3) {
            switch ($N) {
                case 0: return '';
                case 1: return 'сто';
                case 2: return 'двести';
                case 3: return 'триста';
                case 4: return 'четыреста';
                case 5: return 'пятьсот';
                case 6: return 'шестьсот';
                case 7: return 'семьсот';
                case 8: return 'восемьсот';
                case 9: return 'девятьсот';
            }
        }//level 3
    }

    function Gender() {
        return $this->UnitWord['Gender'];
    }

    function UnitWordInRightForm() {
        $result = $this->UnitWord['Base'];
        $slevel = $this->Levels(1);
        if ($slevel == 1) {
            return $result . $this->UnitWord['End1'];
        }
        if (($slevel == 0) or (($slevel >= 5) and ($slevel <= 19))) {
            return $result . $this->UnitWord['End5'];
        }
        if (($slevel >= 2) or ($slevel <= 4)) {
            return $result . $this->UnitWord['End2'];
        }
    }

    private function Convert() {
        if ($this->FNumber == 0) {
            return '';
        }
        $result = '';
        for ($i = 3; $i >= 1; $i--) {
            $s = $this->GetNumberInWord($this->Levels($i), $i);
            if ($s != "") {
                $result .= $s . ' ';
            }
        }//for
        return $result . $this->UnitWordInRightForm() . ' ';
    }

    function ConvertToText($AUnit = array('Gender' => GENNEUTER, 'Base' => '', 'End1' => '', 'End2' => '', 'End5' => '',), $ANumber) {
        $this->UnitWord = $AUnit;
        $this->SetNumber($ANumber);
        return $this->Convert();
    }

    function CountOfUnits($AUnit = array('Gender' => GENNEUTER, 'Base' => '', 'End1' => '', 'End2' => '', 'End5' => '',), $N, $Options = array()) {
        $result = '';
        if (($N == 0) and (!@in_array('ntoExplicitZero', $Options))) {
            return $result;
        }

        if (!@in_array('ntoDigits', $Options)) {
            if (($N < 0) and (@in_array('ntoMinus', $Options))) {
                $result = 'минус ';
            } else
            if (($N > 0) and (@in_array('ntoPlus', $Options))) {
                $result = 'плюс ';
            } else
            if ($N == 0) {
                return 'ноль ' . $AUnit['Base'] . $AUnit['End5'];
            }
        }//if
        else {
            if (($N < 0) and (@in_array('ntoMinus', $Options))) {
                $result = '-';
            } else
            if (($N > 0) and (@in_array('ntoPlus', $Options))) {
                $result = '+';
            }
        }//else

        $N = Abs($N);

        if (@in_array('ntoDigits', $Options)) {
            $this->SetNumber($N);
            $this->UnitWord = $AUnit;
            $result         = $N . " " . $this->UnitWordInRightForm();
        }//if
        else {
            $Mrd = mod(div($N, 1000000000), 1000);
            $Mil = mod(div($N, 1000000), 1000);
            $Th  = mod(div($N, 1000), 1000);
            $Un  = mod($N, 1000);

            $result .=
                    $this->ConvertToText($this->WD_MILLIARD, $Mrd) .
                    $this->ConvertToText($this->WD_MILLION, $Mil) .
                    $this->ConvertToText($this->WD_THOUSEND, $Th);

            if ($Un > 0) {
                $result .= $this->ConvertToText($AUnit, $Un);
            } else {
                $result .= $AUnit['Base'] . $AUnit['End5'];
            }
        }//else
        return $result;
    }

    function CurrencyToText($sum, $price = "RUR") {
        $price  = trim($price);
        $RubSum = Trunc($sum);
        $KopSum = Round(Frac($sum));

        if ($KopSum > 100) {
            $KopSum = round($KopSum / 100, 2);
            $RubSum = $RubSum + Trunc($KopSum);
            $KopSum = FreeZero(Round(Frac($KopSum) * 100));
        }

        $sprice  = $this->WD_RUBLE;
        $sprice1 = $this->WD_KOPECK;
        switch ($price) {
            case 'USD' : $sprice  = $this->WD_USD;
                $sprice1 = $this->WD_CENT;
                break;
            case 'KGS' : $sprice  = $this->WD_SOM;
                $sprice1 = $this->WD_TIYIN;
                break;
        }
        $result = $this->CountOfUnits($sprice, $RubSum, array('ntoExplicitZero')) . ' ' . $this->CountOfUnits($sprice1, $KopSum, array());
        $result = trim($result);
        if ($result != "") {
            $str       = strtoupper($result[0]);
            $result[0] = $str;
        }
        return $result;
    }

}

//end of class number
//-----------------------------------------------------------------------


/*
  $NumberAnalyser = new NumberAnaliz();
  echo $NumberAnalyser->CurrencyToText(10005.36, "KGS");
 */
?>