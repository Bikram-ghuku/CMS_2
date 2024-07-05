package middleware

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/bikram-ghuku/CMS/backend/models"
	"github.com/golang-jwt/jwt/v5"
)

type contextKey string

const claimsKey = contextKey("claims")

func JWTMiddleware(handler http.Handler) http.Handler {
	return http.HandlerFunc(func(res http.ResponseWriter, req *http.Request) {
		var jwt_secret = os.Getenv("JWT_SECRET")
		cookie, err := req.Cookie("session-token")
		if err != nil {
			http.Error(res, "No JWT session token found.", http.StatusUnauthorized)
			return
		}

		tokenString := cookie.Value

		var loginClaims = models.LoginJwtClaims{}
		token, err := jwt.ParseWithClaims(tokenString, &loginClaims, func(t *jwt.Token) (interface{}, error) {
			if _, OK := t.Method.(*jwt.SigningMethodHMAC); !OK {
				return nil, errors.New("bad signed method received")
			}

			return []byte(jwt_secret), nil
		})

		if err != nil {
			if err == jwt.ErrSignatureInvalid {
				http.Error(res, "Invalid token signature", http.StatusBadRequest)
				return
			}
			if err.Error() == fmt.Sprintf("%s: %s", jwt.ErrTokenInvalidClaims.Error(), jwt.ErrTokenExpired.Error()) {
				log.Println("Error: JWT Token Expired")
				http.Error(res, "Session Expired", http.StatusUnauthorized)
				return
			}
			log.Println(err.Error())
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		if !token.Valid {
			log.Println("Error: JWT Token Invalid")
			http.Error(res, "Session Error", http.StatusUnauthorized)
			return
		}

		claims, ok := token.Claims.(*models.LoginJwtClaims)
		if !ok {
			log.Println("Error: JWT Token Invalid")
			http.Error(res, "Session Error", http.StatusBadRequest)
			return
		}
		claimsJSON, err := json.Marshal(claims)
		if err != nil {
			log.Println(res, "Error marshalling claims to JSON: %v", err)
			http.Error(res, "Session Error", http.StatusUnauthorized)
			return
		}

		ctx := context.WithValue(req.Context(), claimsKey, claimsJSON)
		handler.ServeHTTP(res, req.WithContext(ctx))
	})
}
