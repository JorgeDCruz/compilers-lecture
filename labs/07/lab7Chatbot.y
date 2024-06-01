%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME WEATHER VIM MAP

%%

chatbot : greeting
        | farewell
        | query
        | weather_q
        | vimExit_q
        | map_q
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;
weather_q : WEATHER { printf("Chatbot: Today's weather in Guadalajara is 42°C, it's a hellish day. 0% chance of rain."); }

vimExit_q: VIM{ printf("Chatbot: To exit VIM please click esc + : q! and tadah you are now out of vim"); }

map_q: MAP { printf("Chatbot: your route to your house loaded correctly, estimated time for arrival 35 mins"); }



%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
