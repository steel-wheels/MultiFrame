/*
 * Builtin.d.ts 
 */

interface FrameCoreIF {
	_value(p0: string): any ;
	_setValue(p0: string, p1: any): boolean ;
	_addObserver(p0: string, p1: () => void): void ;
}

interface ConsoleIF {
  print(p0 : string): void ;
  error(p0 : string): void ;
  log(p0 : string): void ;
  scan(): string | null ;
}

declare var _application: FrameCoreIF ;
declare var console: ConsoleIF ;


