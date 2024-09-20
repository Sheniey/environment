#!/bin/bash

# Global Variables
VERSION="1.16.1v"
VERSION_DATE="09/19/24"
VERSION_NOTES="|C++| and |C#| were agree."
readme=README.md
name=""
dir="."
default_dir="recon exploits scripts content"
default_file="machine.txt $readme"
default_init="$htb"
default_main="machine.txt"

# Function: Setup directories
setup() {
    local target_dir=$1
    local subdirs=$2

    # Create the main directory if it does not exist
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi

    # Create subdirectories
    for subdir in $subdirs; do
        mkdir -p "$target_dir/$subdir"
    done
}

# Function: Create files
mkfile() {
    local target_dir=$1
    local files=$2

    # Create files in the specified directory
    if [ -d "$target_dir" ]; then
        for file in $files; do
            touch "$target_dir/$file"
        done
    else
        echo "Directory $target_dir does not exist."
    fi
}

# Function: Initialize file content
init() {
    local target_dir=$1
    local content=$2
    local filename=$3

    # Write content to the file in the specified directory
    if [ -d "$target_dir" ]; then
        echo -e "$content" > "$target_dir/$filename"
    else
        echo "Directory $target_dir does not exist."
    fi
}

# Templates for different environments
main_htb="
[-] ... [UNPWNED]:
    [*] Info: ...
    [!] OS: GNU/Linux
    [!] IPv4: 10.10.10.1
    [!] Localhost: 192.168.1.1
    [+] Date: M/S/A; h:m:s
    [+] Time: ...s.
    [?] Method: |ping >> nmap >> ... >> ... >> flag|
    [*] User-Flag: ...
    [*] Root-Flag: ...
"

main_python="
from func import *
from const import *
from var import *

def setup() -> None:
    clear()
    # Setup Code

    return None

def main() -> None:
    # Main Code

    return None

if __name__=='__main__':
    try:
        setup()
        main()

    except Exception as e:
        print()
        print(f' Raised Error: |{e}|... ')
        input()

    finally:
        clear()
"

func_python="
from typing import Iterable, Self
from os import system as sys
from os import name as osname

def clear() -> None:
    ''' This is a Func that Clean the Console in Windows and Unix. :return: None; '''
    
    sys('cls') if osname == 'nt' else sys('clear')
    print()
    return None
"

const_python="
from colorama import init, style, reset
from colorama import Fore as COLOR

init(autoreset=True)
"

main_html="
<!DOCTYPE html>

<html lang=en>
    <head>
        <meta charset='utf-8'>
        <meta name='page web'>
        
        <title>Document</title>
        <link type='stylesheet' href='./style.css'>
    </head>

    <body>
        <header>
            <h1></h1>
            <p><strong></strong></p>
            <br>
            <hr>
        </header>
        <div class='container'>
            <h3></h3>
            <br>
            <p></p> 
        </div>
        <footer>
            <p>Copyright @ </p>
        </footer>

        <link type='' href='./script.js'>
    </body>
</html>
"

main_css="
html {
    font-family: Arial, sans-serif;
}
    
* {
    none;
}

header {
    none;
}

.container {
    none;
}

.footer {
    text-align: right;
}
"

main_c="
#include <stdio.h>

int main()
{
    /* Code */

    return 0;
}
"

main_cpp="
#include 'func.h'
#include 'const.h'
#include <iostream>
#include <stdio.h>

int main()
{
    /* Code */

    return 0;
}
"

main_cs() {
    if [[ -n "$1" && "$1" != "Progam" && "$1" != "Main" ]]; then    
        echo -e "

namespace $1 {

    class Progam
    {

        static void Main(String [] args)
        {
            /* Code */
        }
    }
}
"
    else
        echo -e "

namespace Application {

    class Progam
    {

        static void Main(String [] args)
        {
            /* Code */
        }
    }
}
"
    fi
}

main_java() {
    if [[ -n "$1" && "$1" != "main" ]]; then    
        echo -e "
public class $1 {

    public static void main(String [] args) {
        /* Code */
    }
}
"    
    else
        echo -e "
public class Main {

    public static void main(String [] args) {
        /* Code */
    }
}
" 
    fi
}

# Initialize variables
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--name)
            name="$2"
            shift 2
            ;;
        
        -o|--on)
            dir="$2"
            shift 2
            ;;
        
        --help)
            echo -e "
[!] Usage: 
    [-] environment                         # Make the default developer environment.
    [-] environment <environment>           # Make a developer environment of <environment>.
    [-] environment [args]                  # Make the default developer environment with any [args].
    [-] environment <environment> [args]    # Make a developer environment of <environment> with any [args].

[+] Examples:
    [+] environment -o ~/home/$(echo $USERNAME)/projects
    [+] environment java --name Calculator
    [+] environment python 

[*] Environments:
    [+] Developers:
        [-] Python...   [py]
        [-] Web Site... [html]
        [-] C...        [c]
        [-] C++...      [cpp]
        [-] C#...       [cs]
        [-] Java...     [java]

    [+] Hacking:
        [-] Sheñey... [hacknet]
        [-] Hack The Box... [htb ~ default]

[*] Arguments:
    -n, --name      Name of the file (without file extension).
    -o, --on        Directory where the development environment will be created.

[+] Options:
    --credits       Show the credits of the script.
    --help          Show this help message.
    --version       Show the version of the script.
"
            exit 0
            ;;
        
        --version)
            echo -e " Environment's Version: | $VERSION | ~ [$VERSION_DATE]"
            echo -e "                          [*] $VERSION_NOTEST"
            exit 0
            ;;
        
        --credits)
            echo -e "Environment ~ By: Sheney"
            exit 0
            ;;

        *)
            environment="$1"
            shift
            ;;
    esac
done

# Default environment if not specified
if [ -z "$environment" ]; then
    environment="default"
fi

# Process the specified environment
case "$environment" in
    hacknet|sheney)
        if [ -z "$name" ]; then
            name="target"
        fi
        setup "$dir" "recon exploits scripts"
        mkfile "$dir" "$name.txt $readme"
        ;;
    
    hackthebox|htb)
        if [ -z "$name" ]; then
            name="machine"
        fi
        setup "$dir" "recon exploits scripts"
        mkfile "$dir" "$name.txt $readme"
        init "$dir" "$htb" "$name.txt"
        ;;
    
    python|py)
        if [ -z "$name" ]; then
            name="main"
        fi
        setup "$dir" "resource"
        setup "$dir/resource" "icons images assets documents"
        mkfile "$dir/resource" "$name.py const.py var.py func.py $readme"
        init "$dir" "$main_python" "$name.py"
        init "$dir" "$func_python" "func.py"
        init "$dir" "$const_python" "const.py"
        ;;
    
    html5|html|website)
        if [ -z "$name" ]; then
            name="index"
        fi
        setup "$dir" "resource"
        setup "$dir/resource" "icons images videos links"
        mkfile "$dir" "$name.html style.css script.js const.js $readme"
        init "$dir" "$main_html" "$name.html"
        init "$dir" "$main_css" "style.css"
        ;;
    
    c)
        if [ -z "$name" ]; then
            name="main"
        fi
        setup "$dir" "assets"
        mkfile "$dir" "$name.c $readme"
        init "$dir" "$main_c" "$name.c"
        ;;
    
    cpp|"c++")
        if [ -z "$name" ]; then
            name="main"
        fi
        setup "$dir" "assets"
        mkfile "$dir" "$name.cpp func.h const.h $readme"
        init "$dir" "$main_cpp" "$main.cpp"
        ;;

    csharp|cs|"c#")
        if [ -z "$name" ]; then 
            name="Application"
        fi
        setup "$dir" "assets"
        mkfile "$dir" "$name.cs $readme"
        init "$dir" "$(main_cs "$name")" "$name.cs"
        ;;
    
    java|jav)
        if [ -z "$name" ]; then
            name="Main"
        fi
        setup "$dir" "assets"
        mkfile "$dir" "$name.java $readme"
        init "$dir" "$(main_java "$name")" "$name.java"
        ;;
    
    *)
        # Environment default
        setup "$dir" "$default_dir"
        mkfile "$dir" "$default_file"
        init "$dir" "$default_init" $default_main
        ;;
esac
