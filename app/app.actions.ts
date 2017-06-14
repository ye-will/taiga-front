import { Action } from "@ngrx/store";
import * as Immutable from "immutable";

export class OpenLightboxAction implements Action {
  readonly type = "OPEN_LIGHTBOX";

  constructor(public payload: string) {}
}

export class CloseLightboxAction implements Action {
  readonly type = "CLOSE_LIGHTBOX";
  payload = null;
}

export class StartLoadingAction implements Action {
  readonly type = "START_LOADING";
  payload = null;
}

export class StopLoadingAction implements Action {
  readonly type = "STOP_LOADING";
  payload = null;
}

export class SendFeedbackAction implements Action {
  readonly type = "SEND_FEEDBACK";

  constructor(public payload: string) {}
}

export class SetMetadataAction implements Action {
  readonly type = "SET_METADATA";
  public payload: any;

  constructor(title: string, description: string) {
      this.payload = {title, description};
  }
}
