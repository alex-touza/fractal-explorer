export const createTypedCustomEvent = <T extends CustomEventType>(
	type: T,
	eventInitDict: CustomEventInit<CustomEventHandlersMap[T]>,
) => new CustomEvent(type, eventInitDict);
