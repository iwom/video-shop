export class User {
  constructor(
    readonly email: string,
    readonly username: string,
    readonly password: string
  ) {}
}

export class UserCredentials {
  constructor(
    readonly username: string,
    readonly password: string
  ) {}
}
