import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { CieloConstructor, Cielo, TransactionCreditCardRequestModel, CaptureRequestModel, CancelTransactionRequestModel, EnumBrands } from 'cielo';
admin.initializeApp();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

const merchantId = functions.config().cielo.merchantId;
const merchantKey = functions.config().cielo.merchantKey;

const cieloParams: CieloConstructor = {
    merchantId: merchantId,
    merchantKey: merchantKey,
    sandbox: true,
    debug: true,
}

export const helloWorld = functions.https.onCall((data, context) => {
    return { data: "Hellow from Cloud Functions!!!" };
});
export const getUserData = functions.https.onCall(async (data, context) => {
    if (!context.auth) {
        return {
            "data": "Nenhum usuário logado",
        };
    }

    console.log(context.auth.uid);

    const snapshot = await admin.firestore().collection("users").doc(context.auth.uid).get();

    console.log(snapshot.data());
    return {
        "data": snapshot.data()
    };
});


export const addMessage = functions.https.onCall(async (data, context) => {
    console.log(data);

    const snapshot = await admin.firestore().collection("messages").add(data);

    return { "sucess": snapshot.id };
});


export const onNewOrder = functions.firestore.document("/orders/{orderId}").onCreate((snapshot, context) => {
    const orderId = context.params.orderId;
    console.log(orderId);
});